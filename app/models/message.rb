class Message < ApplicationRecord
  include Searchable

  belongs_to :chat

  settings do
    mappings dynamic: false do
      indexes :content, type: :text
    end
  end
end
