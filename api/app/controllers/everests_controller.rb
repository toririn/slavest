class EverestsController < ApplicationController

  def new
    # 値を抜き出す
    param = params.permit(:user, :channel, :text, :ts).to_h
    # Everest API 処理起動
    JobControll::EverestsNewJob.perform_later(user: param[:user], channel: param[:channel], text: param[:text], ts: param[:ts])
    # メッセージを返す
    render json: { message: "OK", status: "200", result: true }
  end
end
