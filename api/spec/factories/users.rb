FactoryGirl.define do
  # test用Slackで使用しているユーザ情報を入力。imageは今後使う予定なので今はnilにしている。
  factory :user do
    slack_id        { "U0P75C2F8" }
    slack_name      { "toririn" }
    image           { nil }
    employee_number { nil }
    created_at      { Time.zone.yesterday }
    updated_at      { Time.zone.now.beginning_of_day }

    trait :with_channels do
      transient do
        channel_count 3
      end
      after(:create) do |user, evaluator|
        user.channels = create_list(:channel, evaluator.channel_count)
      end
    end

    trait :with_emotions do
      transient do
        emotion_count 10
      end
      after(:create) do |user, evaluator|
        user.emotions = create_list(:emotion, evaluator.emotion_count)
      end
    end

    trait :with_emovalue_option do
      transient do
        all_use false
      end
      after(:create) do |user, evaluator|
        if evaluator.all_use
          user.emovalue_option = create(:emovalue_option, :all_use)
        else
          user.emovalue_option = create(:emovalue_option)
        end
      end
    end
  end
end
