Rails.application.routes.draw do
  root "users#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products
  resources :orders, except: [:destroy]

<<<<<<< HEAD
=======

  resources :category, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
>>>>>>> 15e082d8069160141aa6a3cb60f5180ca973f182
end
