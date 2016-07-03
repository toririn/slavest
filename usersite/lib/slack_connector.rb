class SlackConnector
  def initialize
    @auth_host     = "https://slack.com/oauth/authorize?"
    @acs_host      =  "https://slack.com/api/oauth.access?"
    @client_id     = EasySettings.slack.client_id.to_s
    @client_secret = EasySettings.slack.secret_key
    @scope         = EasySettings.slack.scope
    @team          = EasySettings.slack.team
    @redirect_uri  = EasySettings.slack.redirect_url
    @state         = EasySettings.slack.state
  end

  def auth_path
    "#{@auth_host}client_id=#{@client_id}&state=#{@state}&scope=#{@scope}&team=#{@team}&redirect_uri=#{@redirect_uri}"
  end

  def get_info(code)
    path = "#{@acs_host}client_id=#{@client_id}&client_secret=#{@client_secret}&code=#{code}&redirect_uri=#{@redirect_uri}"

    hc = HTTPClient.new
    response = hc.get(path)
    res_json = JSON.parse(response.body)

    HashWithIndifferentAccess.new(res_json)
  end
end
