class HackatimeAuthController < ApplicationController
  before_action :require_login
  def redirect
    client_id = ENV["HACKATIME_CLIENT_ID"].to_s

    if client_id.blank?
      redirect_to projects_path(error: "auth_not_configured")
      return
    end

    query = {
      response_type: "code",
      client_id: client_id,
      redirect_uri: callback_uri,
      scope: "profile read"
    }

    redirect_to "https://hackatime.hackclub.com/oauth/authorize?#{query.to_query}", allow_other_host: true
  end

  def callback
    code = params[:code].to_s

    if code.blank?
      redirect_to projects_path(error: "missing_code")
      return
    end

    token_response = Faraday.post("https://hackatime.hackclub.com/oauth/token") do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.headers["Accept"] = "application/json"
      req.body = {
        grant_type: "authorization_code",
        client_id: ENV["HACKATIME_CLIENT_ID"],
        client_secret: ENV["HACKATIME_CLIENT_SECRET"],
        code: code,
        redirect_uri: callback_uri
      }.to_query
    end

    unless token_response.success?
      Rails.logger.warn "Hackatime token exchange failed: #{token_response.status} #{token_response.body.to_s[0, 200]}"
      redirect_to projects_path(error: "token_exchange_failed")
      return
    end

    token_data = JSON.parse(token_response.body)
    access_token = token_data["access_token"].to_s

    if access_token.blank?
      redirect_to projects_path(error: "missing_access_token")
      return
    end

    hackatime_uid = extract_uid_from_token(token_data)
    hackatime_uid = fetch_hackatime_uid(access_token) if hackatime_uid.blank?

    if hackatime_uid.blank?
      Rails.logger.warn "Hackatime UID missing; saving token without UID"
    end

    current_user.update!(
      hackatime_token: access_token,
      hackatime_uid: hackatime_uid.presence || current_user.hackatime_uid
    )

    redirect_to projects_path
  rescue JSON::ParserError
    redirect_to projects_path(error: "invalid_token_response")
  rescue Faraday::Error, ActiveRecord::RecordInvalid
    redirect_to projects_path(error: "auth_failed")
  end

  private

  def callback_uri
    ENV["HACKATIME_URI"].presence || auth_hackatime_callback_url
  end

  def fetch_hackatime_uid(access_token)
    return nil if access_token.blank?

    endpoints = [
      "https://hackatime.hackclub.com/api/v1/users/current",
      "https://hackatime.hackclub.com/api/v1/users/me",
      "https://hackatime.hackclub.com/api/v1/me"
    ]

    endpoints.each do |endpoint|
      uid = fetch_uid_from_endpoint(endpoint, access_token)
      return uid if uid.present?
    end

    nil
  end

  def fetch_uid_from_endpoint(endpoint, access_token)
    response = Faraday.get(endpoint) do |req|
      req.headers["Authorization"] = "Bearer #{access_token}"
      req.headers["Accept"] = "application/json"
    end

    unless response.success?
      Rails.logger.warn "Hackatime UID fetch failed (#{endpoint}): #{response.status} #{response.body.to_s[0, 200]}"
      return nil
    end

    payload = JSON.parse(response.body)
    data = payload["data"] || payload["user"] || payload
    uid = data["id"] || data["uid"] || data["user_id"]
    uid.to_s
  rescue JSON::ParserError, Faraday::Error => e
    Rails.logger.warn "Hackatime UID fetch error (#{endpoint}): #{e.class}: #{e.message}"
    nil
  end

  def extract_uid_from_token(token_data)
    return nil unless token_data.is_a?(Hash)

    data = token_data["user"] || token_data["data"] || token_data
    uid = data["id"] || data["uid"] || data["user_id"]
    uid.to_s.presence
  end
end