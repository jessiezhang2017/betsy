Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :products
  resources :orders, except: [:destroy]

<<<<<<< HEAD

=======
>>>>>>> fa260d3c7645cae5a1476e7e60804b62b10d1ba2
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
