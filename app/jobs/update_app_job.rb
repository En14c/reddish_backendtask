class UpdateAppJob < ApplicationJob
  queue_as :default

  def perform(app_id, **fields_to_update)
    app = App.find(app_id)
    app.update(fields_to_update)
  end
end
