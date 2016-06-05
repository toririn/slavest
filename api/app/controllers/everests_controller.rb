class EverestsController < ApplicationController

  def new
    binding.pry

    # 値を抜き出す

    # Everest起動

    # DB登録

    # メッセージを返す
    render json: { message: "OK", status: "200", result: true }

  end
end
