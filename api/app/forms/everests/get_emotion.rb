class Everests::GetEmotion

  attr_accessor :client, :urls

  def initialize
    @client = HTTPClient.new
    @urls = EasySettings.everests.urls
  end

  def get(text)
    client.get_content(url(text))
  end

  private

  def url(text)
    base_url = urls.base + urls.get_emotion
    URI.escape(base_url + text)
  end

end
