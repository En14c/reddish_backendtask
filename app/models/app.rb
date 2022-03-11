class App < ApplicationRecord
  has_secure_token
  has_many :chats, dependent: :delete_all
end
