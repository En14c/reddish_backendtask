class DestroyMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    message.destroy!
    Rails.cache.decrement("reddish_app#{chat.app_id}_chat#{chat.id}_messages_count")
  end
end
