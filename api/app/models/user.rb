class User < ApplicationRecord
  def self.by_slack(id: nil, name: nil)
    if id
      find_by(slack_id: id)
    else
      find_by(slack_name: name)
    end
  end
end
