class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :chat_number
      t.references :app, foreign_key: true
      t.integer :messages_count, default: 0

      t.timestamps
    end
    add_index :chats, [:app_id, :chat_number], unique: true
  end
end
