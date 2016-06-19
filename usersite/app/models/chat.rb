class Chat < ApplicationRecord
  has_one :emotion
  belongs_to :user, foreign_key: :user_id
  belongs_to :channel, foreign_key: :channel_id

  scope :with_user,       -> { includes(:user) }
  scope :with_channel,    -> { includes(:channel) }
  scope :with_emotion,    -> { includes(:emotion) }
  scope :with_user_by,    -> (user)    { with_user.where(users: { id: user.id }) }
  scope :with_channel_by, -> (channel) { with_channel.where(channels: { id: channel.id }) }

  after_create :create_relation_chat_mention_user

  def create_relation_chat_mention_user
    # TODO chat 登録時にrelationテーブルのレコードも作成する
  end
end
