class LapseAuthController < ApplicationController
  before_action :require_login
  def redirect
    client_id = ENV["LAPSE_CLIENT_ID"].to_s

    if client_id.blank?
      redirect_to projects_path(error: "auth_not_configured")
      return
    end

    query = {
      response_type: "code",
      client_id: client_id,
      redirect_uri: callback_uri,
      scope: "timelapse:read timelapse:write snapshot:read snapshot:write comment:write user:read user:write user:keyrelay"
    }

    redirect_to "https://lapse.hackclub.com/oauth/authorize?#{query.to_query}", allow_other_host: true
  end

  def callback
    code = params[:code].to_s

    if code.blank?
      redirect_to projects_path(error: "missing_code")
      return
    end

    token_response = Faraday.post("https://lapse.hackclub.com/oauth/token") do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = {
        grant_type: "authorization_code",
        client_id: ENV["LAPSE_CLIENT_ID"],
        client_secret: ENV["LAPSE_CLIENT_SECRET"],
        code: code,
        redirect_uri: callback_uri
      }.to_json
    end

    unless token_response.success?
      redirect_to projects_path(error: "token_exchange_failed")
      return
    end

    token_data = JSON.parse(token_response.body)
    access_token = token_data["access_token"].to_s

    if access_token.blank?
      redirect_to projects_path(error: "missing_access_token")
      return
    end

    if lapse_uid.blank?
      redirect_to projects_path(error: "lapse_uid_failed")
      return
    end

    current_user.update!(
      lapse_token: access_token,
      lapse_uid: lapse_uid
    )

    redirect_to projects_path
  rescue JSON::ParserError
    redirect_to projects_path(error: "invalid_token_response")
  rescue Faraday::Error, ActiveRecord::RecordInvalid
    redirect_to projects_path(error: "auth_failed")
  end

  private

  def callback_uri
    ENV["LAPSE_URI"].presence || auth_lapse_callback_url
  end
end
