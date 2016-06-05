class JobControll::EverestsNewJob < ApplicationJob
  queue_as :everest_new

  rescue_from(Exception) do |e|
    Rails.logger.error e
  end

  def perform(user: , channel: , text: , ts: )
    client = SimpleSlack::Client.new(EasySettings.slack.api_token)
    send_text = text.gsub(/\A.*\n/, "")
    if client.post.channel(to: channel, text: "#{send_text}\n(emovalue: #{Random.rand(1..100).to_f/100})", name: "slavest")
      Rails.logger.debug "post ok"
    else
      Rails.logger.error "post error"
    end
  end
end
