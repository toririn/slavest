FactoryGirl.define do
  # test用Slackで使用しているユーザ情報を入力。imageは今後使う予定なので今はnilにしている。
  factory :user do
    slack_id        { "U0P75C2F8" }
    slack_name      { "toririn" }
    image           { nil }
    employee_number { nil }
    created_at      { Time.zone.yesterday }
    updated_at      { Time.zone.now.beginning_of_day }

    trait :with_channel do
      channel
    end
  end
end
