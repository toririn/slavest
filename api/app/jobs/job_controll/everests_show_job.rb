class JobControll::EverestsShowJob < ApplicationJob
  queue_as :everest_new

  REFINE_TARGET_MATCH = /@sv|@slavest|\n| |　/

  rescue_from(Exception) do |e|
    Rails.logger.error e
  end

  def perform(user: , channel: , text: )
    params = refine_params(user, channel, text)
    Everests::PostAverageEmovalueJob.perform_later(params)
  end

  # パラメータからユーザID,チャンネルIDを取得し、ハッシュとして返す。
  def refine_params(user, channel, text)
    user_id    = User.by_slack(user).id
    channel_id = Channel.by_slack(channel).id
    begin_at, end_at = refine_text(text)

    { user_id: user_id, channel_id: channel_id, begin_at: begin_at, end_at: end_at }
  rescue => e
      Rails.logger.error e
      raise "#{EasySettings.errors.systems.messages.user_or_channel_presence} - { user: #{user}, channel: #{channel}, text: #{text}, ts: #{ts} }"
  end

  def refine_text(text)
    begin_at_text, end_at_text = text.gsub(REFINE_TARGET_MATCH, "").strip.split(",")[1..2]
    [begin_at_text, end_at_text]
  end
end
