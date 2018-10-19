Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products
  resources :category, only: [:new, :create]

  resources :order_products
  resources :orders, except: [:destroy]
  get "/cart", to: "orders#cart", as: "cart"
  post "/cart", to: "order_products#update"
  get "/checkout", to: "orders#checkout", as: "checkout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
