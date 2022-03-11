Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :apps do
        resources :chats do
          resources :messages
          get "search", to: :search
        end
      end
    end
  end
end
