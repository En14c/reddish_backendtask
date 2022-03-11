class DestroyAppJob < ApplicationJob
  queue_as :default

  def perform(app_id)
    app = App.find(app_id)
    app.destroy!
  end
end
