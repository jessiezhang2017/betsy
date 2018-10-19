Rails.application.routes.draw do
  root "users#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products
  resources :orders, except: [:destroy]
  resources :category, only: [:new, :create]

end
