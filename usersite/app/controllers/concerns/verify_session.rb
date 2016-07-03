module VerifySession
  extend ActiveSupport::Concern

  included do
    before_action :verify_session_created
    before_action :verify_session_timeout
  end

  def verify_session_created
    if current_user.blank?
      redirect_to root_path, notice: "ログインしてください！"
    end
  end

  def verify_session_timeout
    if current_user[:time] <= Time.zone.now.ago(30.minutes)
      session[:user] = nil
      redirect_to root_path
    end

    session[:user]["time"] = Time.zone.now
  end
end
