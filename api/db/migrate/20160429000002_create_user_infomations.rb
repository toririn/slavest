class CreateUserInfomations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infomations do |t|
      t.integer  :user_id
      t.string   :emotion_lank
      t.datetime :last_emotion_day
      t.boolean  :emotion_status


      t.timestamps
    end
  end
end
