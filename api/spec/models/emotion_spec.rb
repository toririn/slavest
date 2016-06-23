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

  describe '#self.average_emovalue' do
    let(:emotions) { create_list(:emotion, 50) }
    let(:user)     { create(:user, :with_emotions, emotion_count: 50) }
    let(:channel)  { create(:channel, :with_emotions, emotion_count: 50) }
    context '正常系:' do
      it '全ユーザのemovalueの平均値を出す' do
        average_emovalue = (emotions.inject(0){|total, emotion| total +=emotion.emovalue })/emotions.size
        expect(Emotion.average_emovalue).to eq average_emovalue.to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f
      end
      it '指定したユーザのemovalueの平均値を出す' do
        average_emovalue = (user.emotions.inject(0){|total, emotion| total +=emotion.emovalue })/user.emotions.size
        expect(Emotion.average_emovalue(user)).to eq average_emovalue.to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f
      end
      it '指定したチャンネルのemovalueの平均値を出す' do
        average_emovalue = (channel.emotions.inject(0){|total, emotion| total +=emotion.emovalue })/channel.emotions.size
        expect(Emotion.average_emovalue(channel)).to eq average_emovalue.to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f
      end

      it 'emovalueが0.0のレコードは平均値を出すときの対象外とする' do
        create_list(:emotion, 30, :zero_emovalue)
        average_emovalue = (emotions.inject(0){|total, emotion| total +=emotion.emovalue })/emotions.size
        expect(Emotion.average_emovalue).to eq average_emovalue.to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f
      end
    end

    context '異常系:' do
      let(:user)     { create(:user) }
      let(:channel)  { create(:channel) }
      it 'レコードが一件もなければ0.0を返すこと' do
        expect(Emotion.average_emovalue).to eq 0.0
        expect(Emotion.average_emovalue(user)).to eq 0.0
        expect(Emotion.average_emovalue(channel)).to eq 0.0
      end
    end
  end
end
