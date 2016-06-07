class Slacks::PostEmovalueJob < ApplicationJob
  queue_as :everest_new

  rescue_from(Exception) do |e|
    Rails.logger.error "#{e.message} - #{e.backtrace.join("\n")}}"
  end

  def perform(user_id: , channel_id: , text: , emovalue: )
    client = SimpleSlack::Client.new(EasySettings.slack.api_token)
    user    = User.find(user_id)
    channel = Channel.find(channel_id)
    send_text = "発言者： #{user.slack_name}\n発言内容： #{text}"
    if client.post.channel(to: channel.slack_id, text: "#{send_text}\n(emovalue: #{emovalue})", name: "slavest")
      Rails.logger.debug "post ok"
    else
      Rails.logger.error "post error"
    end
  end
end
