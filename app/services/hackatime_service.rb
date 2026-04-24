class HackatimeService
  BASE_URL = "https://hackatime.hackclub.com"
  START_DATE = "2026-04-01"

  def self.fetch_projects(access_token)
    return nil if access_token.blank?

    response = connection.get("authenticated/projects", { start_date: START_DATE}) do |req|
      req.headers["Authorization"] = "Bearer #{access_token}"
    end

    if response.success?
      data = JSON.parse(response.body)
      data["projects"] || []
    else
      Rails.logger.error "HackatimeService fetch_projects error: #{response.status}"
      nil
    end
  rescue => e
    Rails.logger.error "HackatimeService fetch_projects exception: #{e.message}"
    nil
  end

  def self.fetch_stats(hackatime_uid, start_date: START_DATE, end_date: nil)
    params = { features: "projects", start_date: start_date }
    params[:end_date] = end_date if end_date

    response = connection.get("authenticated/projects", params)

    if response.success?
      data = JSON.parse(response.body)
      data["projects"] || []
    else
      Rails.logger.error "HackatimeService fetch_stats error: #{response.status}"
      nil
    end
  rescue => e
    Rails.logger.error "HackatimeService fetch_stats exception: #{e.message}"
    nil
  end

  class << self
    private

    def connection
      @connection ||= Faraday.new(url: "#{BASE_URL}/api/v1") do |conn|
        conn.headers["Content-Type"] = "application/json"
      end
    end
  end
end