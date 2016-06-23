class Everests::GetEmotionJob < ApplicationJob
  queue_as :get_emotion

  rescue_from(Exception) do |e|
    Rails.logger.error "#{e.message} - #{e.backtrace.join("\n")}"
  end

  def perform(slack_user_id: , slack_channel_id: , text: , ts: )
    user    = User.by_slack(slack_user_id)
    channel = Channel.by_slack(slack_channel_id)
    chat    = Chat.create(user_id: user.id, channel_id: channel.id, text: text, ts: ts)

    #hc = Everests::GetEmotion.new
    #result = JSON.parse(hc.get(text))
    result = JSON.parse({ emoValue: 0.800100, behavior: false, osychology: false, repeat: "釣りは、だね", featWordCount: 0, congnition: true, emotion: true }.to_json)
    emovalue = result["emoValue"].to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f
    emotion = Emotion.create(chat_id: chat.id, user_id: user.id, channel_id: channel.id, emovalue: emovalue, repeat: result["repeat"])

    client = SlackForm.new
    send_text = "発言者： #{user.slack_name}\n発言内容： #{text}"
    client.post(to: channel, text: "#{send_text}\n(emovalue: #{emotion.emovalue})", name: EasySettings.slavest.bot_names.everest)
    true
  end

end
