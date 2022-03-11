class UpdateChatsJob < ApplicationJob
  queue_as :default

  def perform(chat_id, **fields_to_update)
    chat = Chat.find(chat_id)
    chat.update(fields_to_update)
  end
end
