class DestroyChatsJob < ApplicationJob
  queue_as :default

  def perform(chat_id)
    chat = Chat.find(chat_id)
    chat.destroy!
    Rails.cache.decrement("app_#{chat.app_id}_chats_count")
  end
end
