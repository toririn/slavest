namespace :channels do
  desc "SlackのChannel一覧を取得してDBへ挿入する"
  task update: :environment do |task|
    Slack.configure { |config| config.token = EasySettings.slack.api_token }
    client = Slack.client
    channels = client.channels_list

    Channel.delete_all
    channel_list = channels["channels"].map do |channel|
      created_user_id = User.find_by(slack_id: channel["creator"]).id rescue nil
      { slack_name: channel["name"], slack_id: channel["id"], description: channel["purpose"]["value"], created_user_id: created_user_id }
    end.compact.sort {|a, b| a[0] <=> b[0] }
    channel_list.each do |channel|
      Channel.create(channel)
    end
    puts "Channels アップデート完了！"
   end
end
