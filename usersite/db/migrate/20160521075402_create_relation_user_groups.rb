class CreateRelationUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_user_groups do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
  end
end
