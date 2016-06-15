require 'rails_helper'

describe Chat do

  let(:chat)  { create(:chat) }

  describe '#relation' do
    context 'belongs_to:' do
      it 'user' do
        should belong_to(:user)
      end
      it 'channel' do
        should belong_to(:channel)
      end
    end
    context 'has_one:'
    it 'emotion' do
      should have_one(:emotion)
    end
  end

  describe '#with_user' do
    context '正常系:' do
      it '関連したユーザ情報が取得できること' do
        expect(Chat.with_user.find(chat.id).user.present?).to eq true
      end
    end
  end

  describe '#with_channel' do
    context '正常系:' do
      it '関連したチャンネル情報が取得できること' do
        expect(Chat.with_channel.find(chat.id).channel.present?).to eq true
      end
    end
  end

  describe '#with_user_by' do
    context '正常系：' do
      it '指定したUserオブジェクトに紐付いたChat情報だけが取得できること' do
        expect(Chat.with_user_by(chat.user).first).to eq chat
      end
    end
  end

  describe '#with_channel_by' do
    context '正常系：' do
      it '指定したChannelオブジェクトに紐付いたChat情報だけが取得できること' do
        expect(Chat.with_channel_by(chat.channel).first).to eq chat
      end
    end
  end
end
