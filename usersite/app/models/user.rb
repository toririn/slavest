class User < ApplicationRecord
  has_one  :channel, foreign_key: :created_user_id
  has_one  :emovalue_option
  has_many :chats
  has_many :emotions

  scope :with_channel,  -> { includes(:channel) }
  scope :with_chats,    -> { includes(:chats) }
  scope :with_emotions, -> { includes(:emotions) }

  def self.by_slack(param = nil, id: nil, name: nil)
    if id
      find_by(slack_id: id)
    elsif name
      find_by(slack_name: name)
    else
      find_by(slack_id: param) || find_by(slack_name: param)
    end
  end

  def used_emotion?
    emovalue_option.try(:use_take)
  end
end
