class EmotionsController < ApplicationController

  def create
    param = params.permit(:user, :channel, :text, :ts).to_h

    if User.by_slack(param[:user]).present?
      Everests::GetEmotionJob.perform_later(slack_user_id: param[:user], slack_channel_id: param[:channel], text: param[:text], ts: param[:ts])
      render json: success_json
    else
      render json: worn_json
    end
  end

  def average
    param = params.permit(:user, :channel, :text).to_h

    if User.by_slack(param[:user]).present?
      Everests::PostAverageEmovalueJob.perform_later(slack_user_id: param[:user], slack_channel_id: param[:channel], text: param[:text])
      render json: success_json
    else
      render json: worn_json
    end
  end

  def success_json
    {
      message: EasySettings.controllers.emotions.messages.ok,
      status: 200,
      result: true
    }
  end

  def worn_json
    {
      message: EasySettings.controllers.emotions.messages.user_not_found,
      status: 200,
      result: false
    }
  end
end
