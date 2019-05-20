class CreateArmies < ActiveRecord::Migration[5.2]
  def change
    create_table :armies do |t|
      t.string  "name"
      t.boolean  "messagesent"
      t.string  "job" 

      t.timestamps
    end
  end
end
