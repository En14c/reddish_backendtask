class CreateNewChatsJob < ApplicationJob
  queue_as :default

  def perform(app_id, chat_number)
    app = App.find(app_id)
    app.chats.create!(chat_number: chat_number)
    app.update(chats_count: chat_number)
  end
end
