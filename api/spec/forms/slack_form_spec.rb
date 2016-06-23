require 'rails_helper'

describe SlackForm do
  let(:slack) { SlackForm.new }
  let(:channel) { create(:channel) }

  describe '#channel_convert' do

    context '正常系:' do
      it 'Channel Class の引数を渡すとそのまま値を返すこと' do
        expect(slack.send("channel_convert", channel)).to eq channel
      end
      it 'slack_id もしくは slack_name を渡すとChannel Class を返すこと' do
        expect(slack.send("channel_convert", channel.slack_id)).to eq channel
        expect(slack.send("channel_convert", channel.slack_name)).to eq channel
      end
      it 'slack_id もしくは slack_name のシンボル渡すとChannel Class を返すこと' do
        expect(slack.send("channel_convert", channel.slack_id.to_sym)).to eq channel
        expect(slack.send("channel_convert", channel.slack_name.to_sym)).to eq channel
      end
    end
    context '異常系:' do
      it '正常系でテストをしている以外のオブジェクトを渡すとnilを返すこと' do
        expect(slack.send("channel_convert", [])).to eq nil
        expect(slack.send("channel_convert", {})).to eq nil
      end
    end
  end

  describe '#post' do
    context '正常系:' do
      it 'Channelの Object, slack_id, slack_nameでSlackへテキストを送信ができること。trueを返すこと' do
        expect(slack.post(to: channel, text: "#{Time.zone.now}-rspec-test", name: "rspec-test")).to eq true
        expect(slack.post(to: channel.slack_id, text: "#{Time.zone.now}-rspec-test", name: "rspec-test")).to eq true
        expect(slack.post(to: channel.slack_name, text: "#{Time.zone.now}-rspec-test", name: "rspec-test")).to eq true
      end
    end
    context '異常系:' do
      it 'Slackへの送信に失敗するとfalseが返すこと' do
        expect(slack.post(to: "channel not found", text: "#{Time.zone.now}-rspec-test", name: "rspec-test")).to eq false
      end
    end
  end
end
