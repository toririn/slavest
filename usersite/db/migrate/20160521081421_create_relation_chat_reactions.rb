class CreateRelationChatReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_chat_reactions, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY AUTO_INCREMENT'
      t.integer :chat_id, limit: 8
      t.integer :reaction_id
      t.timestamps
    end
  end
end
