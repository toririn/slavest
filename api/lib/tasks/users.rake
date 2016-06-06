namespace :users do
  desc "SlackのUser一覧を取得してDBへ挿入する"
  task update: :environment do |task|
    Slack.configure { |config| config.token = EasySettings.slack.api_token }
    client = Slack.client
    users  = client.users_list

    User.delete_all
    user_list = users["members"].map do |user|
      { slack_id: user["id"], slack_name: user["name"], image: user["image_24"] }
    end.sort {|a, b| a[:slack_id] <=> b[:slack_id] }
    user_list.each do |user|
      User.create(user)
    end
    puts "Users アップデート完了！"
  end
end
