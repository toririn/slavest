class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY AUTO_INCREMENT'
      t.integer :user_id, null: false
      t.integer :channel_id, null: false
      t.text :text
      t.string :ts
      t.timestamps
    end
  end
end
