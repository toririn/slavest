require 'rails_helper'

describe Channel do

  describe '#relation' do
    context 'has_many:' do
      it 'chats' do
        should have_many(:chats)
      end
      it 'emotions' do
        should have_many(:emotions)
      end
    end
  end

  describe '#by_slack' do
    let(:channel) { create(:channel) }

    context '正常系:' do
      it '引数にSlackのチャンネル名を渡してレコードが取得できること' do
        expect(Channel.by_slack(channel.slack_name).present?).to eq true
      end
      it '引数にSlackのチャンネルIDを渡してレコードが取得できること' do
        expect(Channel.by_slack(channel.slack_id).present?).to eq true
      end
      it 'キーワード引数にSlackのチャンネル名前を渡してレコードが取得できること' do
        expect(Channel.by_slack(name: channel.slack_name).present?).to eq true
      end
      it 'キーワード引数にSlackのチャンネルIDを渡してレコードが取得できること' do
        expect(Channel.by_slack(id: channel.slack_id).present?).to eq true
      end
    end

    context '異常系:' do
      it '存在しないSlackIDや名前を渡すとnilが戻ること' do
        expect(Channel.by_slack(channel.slack_name.concat('none')).nil?).to eq true
        expect(Channel.by_slack(channel.slack_id.concat('none')).nil?).to eq true
        expect(Channel.by_slack(name: channel.slack_name.concat('none')).nil?).to eq true
        expect(Channel.by_slack(id: channel.slack_id.concat('none')).nil?).to eq true
      end
      it '引数を渡さなければnilが戻ること' do
        expect(Channel.by_slack.nil?).to eq true
      end
    end
  end
end
