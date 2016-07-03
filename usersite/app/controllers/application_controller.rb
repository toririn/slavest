class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include VerifySession

  def current_user
    user = session[:user]

    if user
      { id: user["id"], slack_id: user["slack_id"], slack_name: user["slack_name"],time:  user["time"] }
    else
      nil
    end
  end
end
