class CreateEmotions < ActiveRecord::Migration[5.0]
  def change
    create_table :emotions, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY AUTO_INCREMENT'
      t.integer :chat_id, limit: 8
      t.float :emotion
      t.integer :level_id
      t.timestamps
    end
  end
end
