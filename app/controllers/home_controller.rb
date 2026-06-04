class HomeController < ApplicationController
  before_action :require_login
  def index
    token = ENV["BOT_OAUTH_TOKEN"]

    Rails.logger.info("TOKEN PRESENT? #{token.present?}")
    Rails.logger.info("TOKEN: #{token}")

    slack_response = Faraday.get("https://slack.com/api/conversations.history?channel=C0AFQ0Z5NAG") do |req|
      req.headers["Authorization"] = "Bearer #{token}"
    end

    body = JSON.parse(slack_response.body)
    Rails.logger.info(body)

    announcements = body["messages"].select do |msg|
      msg["type"] == "message" && msg["subtype"].nil?
    end


    @announcements = announcements.map do |msg|
      {
        text: slack_to_html(msg["text"]),
        ts: msg["ts"],
        user: msg["user"],
        link: "https://hackclub.slack.com/archives/C0AFQ0Z5NAG/p#{msg['ts'].delete('.')}"
      }

    end

    @messages = [
      "Bomboclat Message #67",
      "Bomboclat Message #68",
      "Bomboclat Message #69",
      "Bomboclat Message #6767",
      "Bomboclat Message #676767",
      "Bomboclat Message #6",
      "Bomboclat Message #7",
      "Bomboclat Message #8",
      "Bomboclat Message #9",
      "Bomboclat Message #10",
      "Bomboclat Message #11",
      "Bomboclat Message #12",
      "Bomboclat Message #13",
      "Bomboclat Message #14",
      "Bomboclat Message #15",
    ]
  end

  def slack_to_html(text)

    text = text.gsub(/:[a-zA-Z0-9_+-]+:/, "")
    text = text.gsub(/<#.*?>/, "")
    text = text.squish


    text = text.gsub(
      /<([^|>]+)\|([^>]+)>/,
      '<a class="link" href="\1">\2</a>'
    )

    text = text.gsub(/\*(.*?)\*/, '<strong>\1</strong>')
    text = text.gsub(/_(.*?)_/, '<em>\1</em>')
    text = text.gsub("\n", "<br>")

    text.html_safe
  end
end
