FactoryGirl.define do
  factory :user do
    slack_id        { "U0P75C2F8" }
    slack_name      { "toririn" }
    image           { nil }
    employee_number { nil }
    created_at      { Time.zone.yesterday }
    updated_at      { Time.zone.now.beginning_of_day }
  end
end
