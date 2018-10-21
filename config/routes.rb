Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # resources :users
  resources :products, except: [:new, :create]
  resources :category, only: [:new, :create]

  resources :order_products
  resources :orders, except: [:destroy]
  get "/cart", to: "orders#cart", as: "cart"
  post "/cart", to: "order_products#update"
  get "/checkout", to: "orders#checkout", as: "checkout"

  resources :users do
    resources :products, only: [:new, :create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
