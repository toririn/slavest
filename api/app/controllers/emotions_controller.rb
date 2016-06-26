class EmotionsController < ApplicationController

  before_action :verify_used_emotion

  def create
    param = params.permit(:user, :channel, :text, :ts).to_h

    Everests::GetEmotionJob.perform_later(slack_user_id: param[:user], slack_channel_id: param[:channel], text: param[:text], ts: param[:ts])
    render json: success_json
  end

  def average
    param = params.permit(:user, :channel, :text).to_h

    Everests::PostAverageEmovalueJob.perform_later(slack_user_id: param[:user], slack_channel_id: param[:channel], text: param[:text])
    render json: success_json
  end

  private

  def verify_used_emotion
    user_slack_id = params[:user]
    user = User.with_emovalue_option.by_slack(id: user_slack_id)
    return render json: worn_json     unless user.present?
    return render json: not_used_json unless user.used_emotion?
  end

  def success_json
    {
      message: EasySettings.controllers.emotions.messages.ok,
      status: 200,
      result: true
    }
  end

  # DBに存在しないユーザであれば警告を返して処理を中断する
  def worn_json
    {
      message: EasySettings.controllers.emotions.messages.user_not_found,
      status: 200,
      result: false
    }
  end

  # 感情値の取得を許可していないユーザであれば処理を中断する
  def not_used_json
    {
      message: EasySettings.controllers.emotions.messages.not_used_emotion,
      status: 200,
      result: false
    }
  end
end
