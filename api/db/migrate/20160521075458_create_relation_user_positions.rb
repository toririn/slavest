class CreateRelationUserPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_user_positions do |t|
      t.integer :user_id
      t.integer :position_id
      t.timestamps
    end
  end
end
