require 'rails_helper'

describe EmotionsController do

  describe 'POST #create' do
    let(:user)    { create(:user) }
    let(:channel) { create(:channel) }
    let(:job)     { Everests::GetEmotionJob.new }

    context '正常系:' do
      before do
        post :create, params: { user: user.slack_id, channel: channel.slack_id, text: "test", ts: "0000000000", api_token: EasySettings.slavest.api_token }
      end
      it '200 OK が返ること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it 'message:OK, statu:200, result:true のJSONが返ること' do
        res = JSON.parse(response.body)
        expect(res["message"]).to eq EasySettings.controllers.emotions.messages.ok
        expect(res["status"]).to eq 200
        expect(res["result"]).to eq true
      end

      # pend
      #let(:work_args) { { slack_user_id: user.slack_id, slack_channel_id: channel.slack_id, text: "#{Time.zone.now}-rspec-test", ts: "00000000.000000" } }
      #it 'Jobが登録されること' do
      #  get_emotion_job = {
      #    job: Everests::GetEmotionJob,
      #    args: [work_args],
      #    at: Time.zone.now.to_i
      #  }
      #  assert_enqueued_with(get_emotion_job) { job.perform(work_args) }
      #end
    end

    context '異常系:' do
      before do
        post :create, params: { user: user.slack_id.concat("missing"), channel: channel.slack_id, text: "test", ts: "0000000000", api_token: EasySettings.slavest.api_token }
      end

      it 'DBに存在しないユーザの投稿があったら警告を返す' do
        res = JSON.parse(response.body)
        expect(res["message"]).to eq EasySettings.controllers.emotions.messages.user_not_found
      end

      it 'statu:200, result:false のJSONが返ること' do
        res = JSON.parse(response.body)
        expect(res["status"]).to eq 200
        expect(res["result"]).to eq false
      end
    end
  end
end
