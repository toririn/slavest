class SessionsController < ApplicationController
  def index
  end

  def create
    if params[:sessions][:key] == EasySettings.models.sessions.key
      session[:sessions_key] = EasySettings.models.sessions.key
    else
      redirect_to sessions_path
    end
  end

  def destroy
    session[:session_key] = nil
    redirect_to sessions_path
  end
end
