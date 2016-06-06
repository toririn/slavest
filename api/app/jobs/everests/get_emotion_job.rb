class Everests::GetEmotionJob < ApplicationJob
  queue_as :everests_get_emotion

  rescue_from(Exception) do |e|
    Rails.logger.error e
  end

  def perform(user: , channel: , text: , ts: , chat_id: )
    hc = HTTPClient.new
    #result = hc.get_content(everests_url + text)
    result = temp_back
    Slacks::PostEmovalueJob(user, channel, text, result["emovalue"])

    # Emotionレコード作成
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
