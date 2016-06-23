class SlackForm

  attr_accessor :client

  def initialize
    @client = SimpleSlack::Client.new(EasySettings.slack.api_token)
  end

  def post(to: , text: "", name: "Slacker")
    channel = channel_convert(to)

    if channel.blank?
      Rails.logger.error "channel not found.  to: #{to}, text: #{text}, name: #{name}"
      return false
    end

    if @client.post.channel(to: channel.slack_id, text: text, name: name)
      Rails.logger.info "post successed.  to: #{channel}, text: #{text}, name: #{name}"
      true
    else
      Rails.logger.error "post failed.  to: #{channel}, text: #{text}, name: #{name}"
      false
    end
  end

  private

  def channel_convert(param)
    case param
    when Channel
      param
    when String
      Channel.by_slack(param)
    when Symbol
      Channel.by_slack(param.to_s)
    end
  end
end
