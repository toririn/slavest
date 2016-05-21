class CreateRelationJoinUserChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_join_user_channels do |t|
      t.integer :channel_id
      t.integer :user_id
      t.timestamps
    end
  end
end
