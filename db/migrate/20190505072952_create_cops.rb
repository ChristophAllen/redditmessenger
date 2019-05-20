class CreateCops < ActiveRecord::Migration[5.2]
  def change
    create_table :cops do |t|
      t.string  "name"
      t.boolean  "messagesent"
      t.string  "job" 

      t.timestamps
    end
  end
end
