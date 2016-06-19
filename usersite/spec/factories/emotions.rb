FactoryGirl.define do
  factory :emotion do
    chat
    chat_id    { chat.id }
    user_id    { chat.user.id }
    channel_id { chat.channel.id }
    emovalue   { rand.to_d.floor(5).to_f }
    repeat     { Faker::Japanese::Name.name.concat("さん、だね。") }
    created_at { Time.zone.now.beginning_of_day }
    updated_at { Time.zone.now.beginning_of_day }
  end
end
