class Everests::PostAverageEmovalueJob < ApplicationJob
  queue_as :post_average_emovalue

  rescue_from(Exception) do |e|
    Rails.logger.error "#{e.message} - #{e.backtrace.join("\n")}"
  end

  def perform(user_id: , channel_id: , begin_at: nil , end_at: nil)
    client = SimpleSlack::Client.new(EasySettings.slack.api_token)
    user = User.find(user_id)
    channel = Channel.find(channel_id)
    begin_at_time = begin_at ? Time.zone.parse(begin_at) : Time.zone.today
    end_at_time   = end_at   ? Time.zone.parse(end_at)   : Time.zone.now

    average_emovalue = Emotion.between(begin_at_time, end_at_time).average_emovalue(user)

    date_text = end_at ? "#{begin_at_time.strftime("%Y/%m/%d")} から #{end_at_time.strftime("%Y/%m/%d")} まで":"#{begin_at_time.strftime("%Y/%m/%d")} "
    send_text = "#{user.slack_name}さんの #{date_text} の感情平均値は #{average_emovalue.round(4)} です。"
    client.post.channel(to: channel.slack_id, text: send_text, name: EasySettings.slavest.bot_names.everest)
  end
end
