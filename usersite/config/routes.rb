Rails.application.routes.draw do
  root controller: :sessions, action: :index
  resources :sessions, only: [:new, :create] do
    collection do
      get :acs
      get :create
    end
  end
  resources :users, only: [:index, :show] do
    resources :emovalue_options, only: [:index, :edit] do
      member do
        post :edit
      end
    end
  end
end
