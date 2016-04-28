class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :slack_id
      t.string :slack_name

      t.timestamps
    end
  end
end
