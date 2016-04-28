class BaseBot

  attr_reader :botter

  def initialize
    @client       = SlackBot.new
    @getter       = @client.botter
    @poster       = @client.poster
    @botter       = @client.botter
    set
  end

  private

  def set
  end
end
