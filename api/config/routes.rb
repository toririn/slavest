Rails.application.routes.draw do
  namespace :emotions do
    post :create
    post :average
  end
end
