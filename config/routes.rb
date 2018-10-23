Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products, except: [:destroy]
  resources :categories, only: [:new, :create]

  resources :order_products
  resources :orders, except: [:destroy]

  get "/cart", to: "orders#cart", as: "cart"
  get "/checkout", to: "orders#checkout", as: "checkout"
  get "/confirmation", to: "orders#confirmation", as: "confirmation"

  patch "/products/:id/retire", to: "products#retire", as: "retire"
  get "/Products_by_category", to: "products#bycategory", as:"bycategory"
  get "/Products_by_merchant", to: "products#bymerchant", as:"bymerchant"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
