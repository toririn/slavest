class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.string :slack_id
      t.string :slack_name
      t.text :description
      t.integer :created_user_id
      t.timestamps
    end
  end
end
