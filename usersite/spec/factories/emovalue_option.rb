FactoryGirl.define do
  factory :emovalue_option do
    user_id                  { 1 }
    use_take                 { false }
    notification_decrease    { 0 }
    notification_increase    { 0 }
    notification_slowdown    { 0 }
    notification_regular     { 0 }
    notification_push_guide  { 0 }
  end
end
