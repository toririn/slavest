FactoryGirl.define do
  factory :chat do
    user
    channel
    user_id         { user.id }
    channel_id      { channel.id }
    text            { "こんにちは。私は元気です。" }
    ts              { Time.zone.now.beginning_of_day.to_i.to_s.concat('.000002') }
    created_at      { Time.zone.now.beginning_of_day }
    updated_at      { Time.zone.now.beginning_of_day }
  end
end
