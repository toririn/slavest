class Emotion < ApplicationRecord
  has_one :chat, foreign_key: :id
  belongs_to :user, foreign_key: :user_id
  belongs_to :channel, foreign_key: :channel_id

  scope :with_chat,    -> { includes(:chat) }
  scope :with_user,    -> { includes(:user) }
  scope :with_channel, -> { includes(:channel) }
  scope :today,        -> { where(created_at: [Time.zone.today..Time.zone.now] ) }
  scope :between,    ->(begin_at, end_at = Time.zone.now) { where(created_at: [begin_at..end_at] ) }
  scope :by_user,    ->(user)             { includes(:user).where(users: { id: user.id }) }
  scope :by_channel, ->(channel)          { includes(:channel).where(channels: { id: channel.id }) }

  def self.average_emovalue(param = nil)
    case param
    when User
      user = param
      by_user(user).average(:emovalue).to_f
    when Channel
      channel = param
      by_channel(channel).average(:emovalue).to_f
    else
      average(:emovalue).to_f
    end
  end
end
