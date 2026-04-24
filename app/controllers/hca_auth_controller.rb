class HcaAuthController < ApplicationController
  def redirect
    client_id = ENV["HCA_CLIENT_ID"].to_s
    redirect_uri = oauth_redirect_uri
    email = params[:email].to_s.strip

    if client_id.blank?
      redirect_to root_path(error: "auth_not_configured")
      return
    end

    query = {
      response_type: "code",
      client_id: client_id,
      redirect_uri: redirect_uri,
      scope: "openid email name profile verification_status slack_id"
    }
    query[:login_hint] = email if email.present?

    redirect_to "https://auth.hackclub.com/oauth/authorize?#{query.to_query}", allow_other_host: true
  end

  def callback
    code = params[:code].to_s
    if code.blank?
      redirect_to root_path(error: "missing_code")
      return
    end

    token_response = Faraday.post("https://auth.hackclub.com/oauth/token") do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = {
        grant_type: "authorization_code",
        client_id: ENV["HCA_CLIENT_ID"],
        client_secret: ENV["HCA_CLIENT_SECRET"],
        code: code,
        redirect_uri: oauth_redirect_uri
      }.to_json
    end

    unless token_response.success?
      redirect_to root_path(error: "token_exchange_failed")
      return
    end

    token_data = JSON.parse(token_response.body)
    access_token = token_data["access_token"].to_s

    if access_token.blank?
      redirect_to root_path(error: "missing_access_token")
      return
    end

    user_info = normalize_user_info(token_data)

    if user_info["email"].blank?
      me_response = Faraday.get("https://auth.hackclub.com/api/v1/me") do |req|
        req.headers["Authorization"] = "Bearer #{access_token}"
        req.headers["Accept"] = "application/json"
      end

      if me_response.success?
        me_data = JSON.parse(me_response.body)
        user_info = normalize_user_info(me_data)
      end
    end

    email = user_info["email"].to_s
    if email.blank?
      redirect_to root_path(error: "invalid_user_payload")
      return
    end

    user = User.find_or_initialize_by(email: email)
    user.name = user_info["name"] if user_info["name"].present?

    fallback_username = user_info["name"].to_s.split(/\s+/).first
    resolved_username = user_info["username"].presence || fallback_username
    user.username = resolved_username if resolved_username.present?

    user.slack_id = user_info["slack_id"] if user_info["slack_id"].present?
    user.verification_status = user_info["verification_status"].presence || user.verification_status || "needs_submission"
    user.save!

    session[:user_id] = user.id
    redirect_to home_path
  rescue JSON::ParserError
    redirect_to root_path(error: "invalid_token_response")
  rescue Faraday::Error, ActiveRecord::RecordInvalid
    redirect_to root_path(error: "auth_failed")
  end

  def signout
    reset_session
    redirect_to root_path
  end

  private

  def normalize_user_info(payload)
    raw = payload["user"] || payload["identity"] || payload

    username = raw["username"].to_s.strip.presence
    first_name = raw["first_name"].to_s.strip.presence
    last_name = raw["last_name"].to_s.strip.presence

    full_name = raw["name"].to_s.strip
    if full_name.blank?
      full_name = [first_name, last_name].compact.join(" ")
    end

    normalized_name = if username.present?
      full_name.presence
    else
      first_name || full_name.to_s.split(/\s+/).first
    end

    {
      "email" => raw["email"].presence || raw["primary_email"].presence,
      "name" => normalized_name,
      "username" => username,
      "slack_id" => raw["slack_id"].presence,
      "verification_status" => raw["verification_status"].presence
    }
  end

  def oauth_redirect_uri
    ENV["HCA_URI"].presence || auth_callback_url
  end
end