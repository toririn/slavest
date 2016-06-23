require 'rails_helper'

describe Everests::PostAverageEmovalueJob do
  let(:job)     { Everests::PostAverageEmovalueJob.new }
  let(:user)    { create(:user) }
  let(:channel) { create(:channel) }

  describe '#perform' do
    context '正常系:' do
      let(:work) { job.perform(slack_user_id: user.slack_id, slack_channel_id: channel.slack_id, text: "@slarest\naverage,6/1,6/2") }
      it 'job内の処理が正常に完了してtrueを返すこと' do
        expect(work).to eq true
      end
    end
  end

  describe '#separate_term_date' do
    context '正常系:' do
      it 'カンマ区切りで日付の情報が2つ渡されたとき、2つを分離して配列で渡すこと' do
        expect(job.separate_term_date("@slavest\naverage,6/1,6/2")).to eq ['6/1', '6/2']
      end
      it 'カンマ区切りで日付の情報が1つ渡されたとき、1つを分離して,もう1つをnilにした配列で渡すこと' do
        expect(job.separate_term_date("@slavest\naverage,6/1")).to eq ['6/1', nil]
      end
      it '日付の情報がないとき、nilを配列で渡すこと' do
        expect(job.separate_term_date("@slavest\naverage")).to eq [nil, nil]
        expect(job.separate_term_date("@slavest\naverage,")).to eq [nil, nil]
        expect(job.separate_term_date("@slavest\naverage,,")).to eq [nil, nil]
      end
    end
  end

end
