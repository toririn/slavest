class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.integer :channel_id
      t.integer :emotion_if
      t.text    :chat

      t.timestamps
    end
  end
end
