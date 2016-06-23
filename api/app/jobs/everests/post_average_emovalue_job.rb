class Everests::PostAverageEmovalueJob < ApplicationJob
  queue_as :post_average_emovalue
  REFINE_TARGET_MATCH = /@sv|@slavest|\n| |　/

  rescue_from(Exception) do |e|
    Rails.logger.error "#{e.message} - #{e.backtrace.join("\n")}"
  end

  def perform(slack_user_id: , slack_channel_id: , text: )
    user    = User.by_slack(id: slack_user_id)
    channel = Channel.by_slack(id: slack_channel_id)

    begin_at, end_at = separate_term_date(text)
    begin_at_time    = begin_at ? Time.zone.parse(begin_at) : Time.zone.today
    end_at_time      = end_at   ? Time.zone.parse(end_at)   : Time.zone.now

    average_emovalue = Emotion.between(begin_at_time, end_at_time).average_emovalue(user)

    client = SlackForm.new
    date_text = end_at ? "#{begin_at_time.strftime("%Y/%m/%d")} から #{end_at_time.strftime("%Y/%m/%d")} まで":"#{begin_at_time.strftime("%Y/%m/%d")} "
    send_text = "#{user.slack_name}さんの #{date_text} の感情平均値は #{average_emovalue} です。"
    client.post(to: channel, text: send_text, name: EasySettings.slavest.bot_names.everest)
    true
  end

  def separate_term_date(text)
    begin_at_text, end_at_text = text.gsub(REFINE_TARGET_MATCH, "").strip.split(",")[1..2]
    [begin_at_text.presence, end_at_text.presence]
  end
end
