FactoryGirl.define do
  factory :channel do
    slack_id        { "C14TGRC1G" }
    slack_name      { "times_toririn" }
    description     { "分報です。" }
    created_user_id { 1  }
    created_at      { Time.zone.yesterday }
    updated_at      { Time.zone.now.beginning_of_day }
  end
end
