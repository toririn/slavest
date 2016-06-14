class Chat < ApplicationRecord
  has_one :emotion
  belongs_to :user, foreign_key: :id
  belongs_to :channel

  scope :with_user, -> { includes(:user) }
  scope :with_channel, -> { includes(:channel) }

  scope :with_user_by,    -> (user)    { with_user.where(users: { id: user.id }) }
  scope :with_channel_by, -> (channel) { with_channel.where(channels: { id: channel.id }) }
  #"channel"=>"C14TGRC1G", "user"=>"U0P75C2F8", "text"=>"@sv\nへい", "ts"=>"1465219725.000002", "team"=>"T0P71EC2H", "api_token"=>"helloworld",
  after_create :create_relation_chat_mention_user

  scope :with_emotion, -> { includes(:emotion) }

  def create_relation_chat_mention_user
    # TODO chat 登録時にrelationテーブルのレコードも作成する
  end
end
