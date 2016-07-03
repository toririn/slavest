require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe '#relation' do
    context 'has_many:' do
      it 'channel' do
        should have_many(:channels)
      end
      it 'chats' do
        should have_many(:chats)
      end
      it 'emotions' do
        should have_many(:emotions)
      end
    end
    context 'has_one:' do
      it 'emovalue_option' do
        should have_one(:emovalue_option)
      end
    end
  end

  describe '#with_channels' do
    let(:user) { create(:user, :with_channels) }

    context '正常系:' do
      it '作成したチャンネルのオブジェクトを取得できること' do
        expect(User.with_channels.find(user.id).channels).to eq user.channels
      end
    end
  end

  describe '#with_emovalue_option' do
    let(:user) { create(:user, :with_emovalue_option) }

    context '正常系:' do
      it 'ユーザのEmovalueオプションオブジェクトを取得できること' do
        expect(User.with_emovalue_option.find(user.id).emovalue_option).to eq user.emovalue_option
      end
    end
  end

  describe '#by_slack' do
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

  describe '#used_emotion?' do
    let(:user) { create(:user, :with_emovalue_option) }
    context '正常系:' do
      context 'ユーザが感情値の取得を許可していなければ' do
        it 'falseが返ること' do
          expect(user.used_emotion?).to eq false
        end
      end
      context 'ユーザが感情値の取得を許可していれば' do
        it 'trueが返ること' do
          user.emovalue_option.use_take = true
          expect(user.used_emotion?).to eq true
        end
      end
    end
  end
end
