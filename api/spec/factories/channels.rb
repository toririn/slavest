FactoryGirl.define do
  # test用Slackで使用しているチャンネル情報を入力。
  factory :channel do
    slack_id        { "C14TGRC1G" }
    slack_name      { "times_toririn" }
    description     { "分報です。" }
    created_user_id { 1  }
    created_at      { Time.zone.yesterday }
    updated_at      { Time.zone.now.beginning_of_day }

    trait :with_emotions do
      transient do
        emotion_count 10
      end
      after(:create) do |channel, evaluator|
        channel.emotions = create_list(:emotion, evaluator.emotion_count)
      end
    end
  end
end
