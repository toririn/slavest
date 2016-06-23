namespace :emovalue_options do
  desc "全ユーザのEmovalueOptionを初期化する"
  task create: :environment do |task|
    users  = User.all

    EmovalueOption.delete_all
    users.each do |user|
      EmovalueOption.create(user_id: user.id)
    end
    puts "Emovalue options Create Complete!"
  end

  desc "EmovalueOptionが設定されていない"
  task update: :environment do |task|
    users  = User.all

    users.each do |user|
      EmovalueOption.find_or_create_by(user_id: user.id)
    end
    puts "Emovalue options Update Complete!"
  end
end
