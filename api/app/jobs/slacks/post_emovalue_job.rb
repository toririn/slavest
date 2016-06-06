class Slacks::PostEmovalueJob < ApplicationJob
  queue_as :everest_new

  rescue_from(Exception) do |e|
    Rails.logger.error e
  end

  def perform(user: , channel: , text: , emovalue: )
    client = SimpleSlack::Client.new(EasySettings.slack.api_token)
    send_text = "発言者：#{user}\n#{text}"
    if client.post.channel(to: channel, text: "#{send_text}\n(emovalue: #{emovalue})", name: "slavest")
      Rails.logger.debug "post ok"
    else
      Rails.logger.error "post error"
    end
  end
end
