class User < ApplicationRecord
  has_many :chats

  scope :with_chats, -> { includes(:chats) }

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
