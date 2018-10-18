Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products
  resources :orders, except: [:destroy]

end
