require 'rails_helper'

describe User do
  describe '#by_slack' do
    let(:user) { User.new(slack_id: "C0test00", slack_name: "test") }

    context '正常系:' do
      it 'userが存在すること' do
        expect(user.present?).to eq true
      end
    end
  end
end
