class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :message_number, default: 0
      t.references :chat, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
    add_index :messages, [:chat_id, :message_number], unique: true
  end
end
