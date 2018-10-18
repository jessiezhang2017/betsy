Rails.application.routes.draw do
  resources :users
  resources :orders, except: [:destroy]

  get 'user/index'
  get 'user/new'
  get 'user/show'
  get 'user/update'
  get 'user/destroy'
  get 'user/edit'
  get 'user/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
