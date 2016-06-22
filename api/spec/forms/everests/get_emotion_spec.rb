require 'rails_helper'

describe Everests::GetEmotion do

  describe '#with_channel' do
    let(:form) { Everests::GetEmotion.new }

    context '正常系:' do
      it 'API用のURLが正しい(http://192.168.20.2:24080/calcEmotion?text=テスト)こと' do
        expect(form.send(:url, "テスト")).to eq "http://192.168.20.2:24080/calcEmotion?text=%E3%83%86%E3%82%B9%E3%83%88"
      end
    end
  end
end
