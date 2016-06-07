class Everests::GetEmotionJob < ApplicationJob
  queue_as :everests_get_emotion

  rescue_from(Exception) do |e|
    Rails.logger.error "#{e.message} - #{e.backtrace.join("\n")}"
  end

  def perform(user_id: , channel_id: , text: , ts: , chat_id: )
    hc = ::HTTPClient.new
    #result = hc.get_content(everests_url + text)
    #一時的にjsonを生成
    result = JSON.parse(temp_back)
    Slacks::PostEmovalueJob.perform_later(user_id: user_id, channel_id: channel_id, text: text, emovalue: result["emovalue"])

    Emotion.create(chat_id: chat_id, emovalue: result["emovalue"], repeat: result["repeat"])
  end

  def everests_url
    urls = EasySettings.everests.urls
    urls.base + urls.gets.emotion
  end

  def temp_back
    { emovalue: 0.800100, behavior: false, osychology: false, repeat: "釣りは、だね", featWordCount: 0, congnition: true, emotion: true }.to_json
  end
end
