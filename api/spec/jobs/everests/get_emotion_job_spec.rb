require 'rails_helper'

describe Everests::GetEmotionJob do
  let(:job)     { Everests::GetEmotionJob.new }
  let(:user)    { create(:user) }
  let(:channel) { create(:channel) }

  describe '#perform' do

    context '正常系:' do
      let(:work) { job.perform(slack_user_id: user.slack_id, slack_channel_id: channel.slack_id, text: "#{Time.zone.now}-rspec-test", ts: "00000000.000000") }
      it 'job内の処理が正常に完了してtrueを返すこと' do
        expect(work).to eq true
      end
      it 'job実行後Chatレコードが1増えていること' do
        expect{work}.to change(Chat, :count).by(1)
      end
      it 'job実行後Emotionレコードが1増えていること' do
        expect{work}.to change(Emotion, :count).by(1)
      end
    end
  end

end
