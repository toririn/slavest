class Emotion < ApplicationRecord
  has_one    :chat, foreign_key: :id
  belongs_to :user, foreign_key: :user_id
  belongs_to :channel, foreign_key: :channel_id

  scope :with_chat,    -> { includes(:chat) }
  scope :with_user,    -> { includes(:user) }
  scope :with_channel, -> { includes(:channel) }
  scope :today,        -> { where(created_at: [Time.zone.today..Time.zone.now] ) }
  scope :between,    ->(begin_at, end_at = Time.zone.now) { where(created_at: [begin_at..end_at] ) }
  scope :by_user,    ->(user)             { includes(:user).where(users: { id: user.id }) }
  scope :by_channel, ->(channel)          { includes(:channel).where(channels: { id: channel.id }) }
  scope :without_zero_emovalue, -> { where.not(emovalue: 0.0 ) }

  def self.average_emovalue(refine_target = nil)
    case refine_target
    when User
      user = refine_target
      average_emovalue = by_user(user).without_zero_emovalue.average(:emovalue)
    when Channel
      channel = refine_target
      average_emovalue = by_channel(channel).without_zero_emovalue.average(:emovalue)
    else
      average_emovalue = without_zero_emovalue.average(:emovalue)
    end

    average_emovalue.to_d.floor(EasySettings.models.emotion.emovalue_number_digits).to_f
  end
end
