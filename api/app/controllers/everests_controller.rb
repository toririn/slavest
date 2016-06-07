class EverestsController < ApplicationController

  def new
    param = params.permit(:user, :channel, :text, :ts).to_h

    if User.by_slack(param[:user]).present?
      JobControll::EverestsNewJob.perform_later(user: param[:user], channel: param[:channel], text: param[:text], ts: param[:ts])
      render json: { message: "OK", status: "200", result: true }
    else
      render json: { message: "WORN - 存在しないユーザです", status: "200", result: true }
    end
  end
end
