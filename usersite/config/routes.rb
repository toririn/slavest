Rails.application.routes.draw do
  root controller: :sessions, action: :index
  resources :sessions, only: [:create]
  resources :users
end
