class Emotion < ApplicationRecord
  has_one :chat, foreign_key: :id

  scope :with_chat, -> { includes(:chat) }
end
