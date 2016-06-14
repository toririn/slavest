class CreateEmotions < ActiveRecord::Migration[5.0]
  def change
    create_table :emotions, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY AUTO_INCREMENT'
      t.integer :chat_id, limit: 8
      t.integer :user_id
      t.integer :channel_id
      t.float :emovalue
      t.text :repeat
      t.timestamps
    end
  end
end
