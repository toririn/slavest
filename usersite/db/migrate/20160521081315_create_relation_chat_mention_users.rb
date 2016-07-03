class CreateRelationChatMentionUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_chat_mention_users, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY AUTO_INCREMENT'
      t.integer :chat_id, limit: 8
      t.integer :user_id
      t.timestamps
    end
  end
end
