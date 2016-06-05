Rails.application.routes.draw do
  resources :everests, only: [:new]
  post "everests/new" => "everests#new"
  get  "test" => "slavest_base#test"
  post "test" => "slavest_base#test"
  post "auth" => "slavest_base#auth"
end
