class Chat < ApplicationRecord
  #"channel"=>"C14TGRC1G", "user"=>"U0P75C2F8", "text"=>"@sv\nへい", "ts"=>"1465219725.000002", "team"=>"T0P71EC2H", "api_token"=>"helloworld",
  after_create :create_relation_chat_mention_user

  def create_relation_chat_mention_user
    # TODO chat 登録時にrelationテーブルのレコードも作成する
  end
end
