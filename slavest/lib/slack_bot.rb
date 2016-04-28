class SlackBot

  attr_reader :client, :botter, :getter, :poster
  def initialize
    @client = SimpleSlack::Client.new(CONFIG["slack"]["api_token"])
    @getter = @client.get
    @poster = @client.post
    @botter = @client.bot
  end
end
