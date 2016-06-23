class EmotionsController < ApplicationController

  def create
    param = params.permit(:user, :channel, :text, :ts).to_h

    if User.by_slack(param[:user]).present?
      Everests::GetEmotionJob.perform_later(user: param[:user], channel: param[:channel], text: param[:text], ts: param[:ts])
      render json: { message: "OK", status: "200", result: true }
    else
      render json: { message: "WORN - 存在しないユーザです", status: "200", result: false }
    end
  end

  def average
    param = params.permit(:user, :channel, :text).to_h

    if User.by_slack(param[:user]).present?
      JobControll::EverestsShowJob.perform_later(user: param[:user], channel: param[:channel], text: param[:text])
      render json: { message: "OK", status: "200", result: true }
    else
      render json: { message: "WORN - 存在しないユーザです", status: "200", result: false }
    end
  end
end
