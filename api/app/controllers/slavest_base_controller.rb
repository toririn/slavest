class SlavestBaseController < ApplicationController
  def auth
    param = { message: "hello" }
    render json: param
  end
end
