require 'rails_helper'

describe Emotion do

  let(:emotion)  { create(:emotion) }

  describe '#relation' do
    context 'belongs_to:' do
      it 'user' do
        should belong_to(:user)
      end

      it 'channel' do
        should belong_to(:channel)
      end
    end
    context 'has_one:' do
      it 'chat' do
        should have_one(:chat)
      end
    end
  end

  describe '#with_chat' do
    context '正常系:' do
      it '関連したChatのオブジェクトが取得できること' do
        expect(Emotion.with_chat.find(emotion.id).chat).to eq emotion.chat
      end
    end
  end
  describe '#with_user' do
    context '正常系:' do
      it '関連したユーザ情報のみのオブジェクトが取得できること' do
        expect(Emotion.with_user.find(emotion.id).user).to eq emotion.user
      end
    end
  end

  describe '#with_channel' do
    context '正常系:' do
      it '関連したユーザ情報のみのオブジェクトが取得できること' do
        expect(Emotion.with_channel.find(emotion.id).channel).to eq emotion.channel
      end
    end
  end
end
