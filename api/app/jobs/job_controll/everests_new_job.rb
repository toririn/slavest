class JobControll::EverestsNewJob < ApplicationJob
  queue_as :everest_new

  rescue_from(Exception) do |e|
    Rails.logger.error e
  end

  def perform(user: , channel: , text: , ts: )
    params = refine_params(user, channel, text, ts)

    chat = Chat.create(params)
    Everests::GetEmotionJob.perform_later(params.merge(chat_id: chat.id))
  end

  # パラメータからユーザID,チャンネルIDを取得し、ハッシュとして返す。
  def refine_params(user, channel, text, ts)
    user_id    = User.by_slack(user).id
    channel_id = Channel.by_slack(channel).id
    { user_id: user_id, channel_id: channel_id, text: text, ts: ts}
  rescue => e
      Rails.logger.error e
      raise "#{EasySettings.errors.systems.messages.user_or_channel_presence} - { user: #{user}, channel: #{channel}, text: #{text}, ts: #{ts} }"
  end
end
