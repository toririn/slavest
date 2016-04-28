class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.string :slack_id
      t.string :slack_name
      t.string :type

      t.timestamps
    end
  end
end
