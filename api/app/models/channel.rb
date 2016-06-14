class Channel < ApplicationRecord
  has_many :chats
  has_many :emotions

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
end
