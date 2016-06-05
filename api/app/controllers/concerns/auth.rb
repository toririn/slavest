module Auth
  extend ActiveSupport::Concern

  included do
    before_action :verify_api_token
  end

  def verify_api_token
    unless params[:api_token] == EasySettings.slack.api_token
      render json: { message: "invalid api token"}
    end
  end

  def auth
    param = { message: "hello world" }
    render json: param
  end
end
