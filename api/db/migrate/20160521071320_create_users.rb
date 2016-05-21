class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, force: true do |t|
      t.string :slack_id, null: false, limit: 9
      t.string :slack_name, null: false
      t.string :image
      t.string :employee_number
      t.timestamps
    end
  end
end
