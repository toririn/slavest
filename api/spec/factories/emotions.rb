FactoryGirl.define do
  factory :emotion do
    chat
    chat_id    { chat.id }
    user_id    { chat.user.id }
    channel_id { chat.channel.id }
    emovalue   { rand.to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f }
    repeat     { Faker::Japanese::Name.name.concat("さん、だね。") }
    created_at { Time.zone.now.beginning_of_day }
    updated_at { Time.zone.now.beginning_of_day }

    trait :zero_emovalue do
      emovalue { 0.0 }
    end
  end
end
