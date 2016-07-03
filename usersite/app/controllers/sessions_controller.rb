class SessionsController < ApplicationController

  skip_before_action :verify_session_created
  skip_before_action :verify_session_timeout

  def index
    session[:user] = nil
  end

  def new
    client = SlackConnector.new
    redirect_to client.auth_path
  end

  def acs
    state = params[:state]
    raise "invalid state" unless state == EasySettings.slack.state

    client = SlackConnector.new
    code = params[:code]

    res = client.get_info(code)

    if res[:ok]
      raise "invalid team" unless res[:team_id] == EasySettings.slack.team_id

      user = User.by_slack(id: res[:user_id])
      session[:user] = {}.tap do |u|
        u[:id]         = user.id
        u[:slack_id]   = user.slack_id
        u[:slack_name] = user.slack_name
        u[:time]       = Time.zone.now
      end

      redirect_to user_emovalue_options_path(user_id: user.id)
    else
      raise "no login"
    end
  end

  def destroy
    session[:session_key] = nil
    redirect_to sessions_path
  end
end
