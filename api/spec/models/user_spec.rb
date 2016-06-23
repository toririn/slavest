require 'rails_helper'

describe User do

  describe '#relation' do
    context 'has_many:' do
      it 'chats' do
        should have_many(:chats)
      end
      it 'emotions' do
        should have_many(:emotions)
      end
    end
    context 'has_one:' do
      it 'channel' do
        should have_one(:channel)
      end
    end
  end

  describe '#with_channel' do
    let(:user) { create(:user, :with_channel) }

    context '正常系:' do
      it '作成したチャンネルのオブジェクトを取得できること' do
        expect(User.with_channel.find(user.id).channel).to eq user.channel
      end
    end
  end

  describe '#by_slack' do
    let(:user) { create(:user) }

    context '正常系:' do
      it '引数にSlackの名前を渡してレコードが取得できること' do
        expect(User.by_slack(user.slack_name).present?).to eq true
      end
      it '引数にSlackのIDを渡してレコードが取得できること' do
        expect(User.by_slack(user.slack_id).present?).to eq true
      end
      it 'キーワード引数にSlackの名前を渡してレコードが取得できること' do
        expect(User.by_slack(name: user.slack_name).present?).to eq true
      end
      it 'キーワード引数にSlackのIDを渡してレコードが取得できること' do
        expect(User.by_slack(id: user.slack_id).present?).to eq true
      end
    end

    context '異常系:' do
      it '存在しないSlackIDや名前を渡すとnilが戻ること' do
        expect(User.by_slack(user.slack_name.concat('none')).nil?).to eq true
        expect(User.by_slack(user.slack_id.concat('none')).nil?).to eq true
        expect(User.by_slack(name: user.slack_name.concat('none')).nil?).to eq true
        expect(User.by_slack(id: user.slack_id.concat('none')).nil?).to eq true
      end
      it '引数を渡さなければnilが戻ること' do
        expect(User.by_slack.nil?).to eq true
      end
    end
  end
end
