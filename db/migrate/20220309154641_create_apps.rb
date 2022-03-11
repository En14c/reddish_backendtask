class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :token
      t.integer :chats_count, default: 0
      t.string :name, null: false

      t.timestamps
    end
    add_index :apps, :token, unique: true
  end
end
