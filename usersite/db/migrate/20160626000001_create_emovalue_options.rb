class CreateEmovalueOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :emovalue_options, force: true do |t|
      t.integer :user_id, null: false
      t.boolean :use_take, default: false
      # emovalueの減少が感知されたときに通知を受けるかの設定
      # 0: 受けない。 1: 受ける（頻度多め） 2: 受ける（頻度少なめ）
      t.integer :notification_decrease, null: false, default: 0, limit: 1
      # emovalueの増加が感知されたときに通知を受けるかの設定
      # 0: 受けない。 1: 受ける（頻度多め） 2: 受ける（頻度少なめ）
      t.integer :notification_increase, null: false, default: 0, limit: 1
      # emovalueの増減が見られないとき、発言がないとき通知を受けるかの設定
      # 0: 受けない。 1: 受ける（頻度多め） 2: 受ける（頻度少なめ）
      t.integer :notification_slowdown, null: false, default: 0, limit: 1
      # 定期的に今の気分を聞かれる通知を受けるかの設定
      # 0: 受けない。 1: 受ける（朝、昼、夕方） 2: 受ける（朝） 3: 受ける(昼)
      # 4: 受ける（夕方) 5: 受ける（朝、昼) 6: 受ける(朝、夕方) 7: 受ける(昼、夕方)
      t.integer :notification_regular, null: false, default: 0, limit: 1
      # 開発メンバーからの連絡通知を受け取るかの設定
      # 0: 受けない 1: 受ける
      t.integer :notification_push_guide, null: false, default: 0, limit: 1
      t.timestamps
    end
  end
end
