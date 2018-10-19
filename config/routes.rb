Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products
  resources :category, only: [:new, :create]

  resources :orders, except: [:destroy]
  get "/cart", to: "orders#cart", as: "cart"
  get "/checkout", to: "orders#checkout", as: "checkout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
