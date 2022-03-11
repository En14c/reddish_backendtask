class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id, message_number, content)
    chat = Chat.find(chat_id)
    message = chat.messages.create!(message_number: message_number, content: content)
    chat.update(messages_count: message_number)
  end
end
