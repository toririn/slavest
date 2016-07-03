class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end