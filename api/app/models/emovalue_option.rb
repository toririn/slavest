class EmovalueOption < ApplicationRecord
  has_one  :user, primary_key: :user_id

  scope :with_user,  -> { includes(:user) }
end
