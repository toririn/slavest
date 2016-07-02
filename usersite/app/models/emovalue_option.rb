class EmovalueOption < ApplicationRecord
  has_one  :user, primary_key: :user_id, foreign_key: :id

  validates :use_take, inclusion: { in: [true, false] }
  validates :notification_decrease, :notification_increase, :notification_slowdown, :notification_regular, :notification_push_guide,
    numericality: { only_integer: true }

  scope :with_user,  -> { includes(:user) }
end
