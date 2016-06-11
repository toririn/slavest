Rails.application.routes.draw do
  resources :everests, only: [:new]
  post "everests/new"  => "everests#new"
  post "everests/show" => "everests#show"
  get  "test" => "slavest_base#test"
  post "test" => "slavest_base#test"
  post "auth" => "slavest_base#auth"
end
