Rails.application.routes.draw do
  resources :orders, except: [:destroy]
<<<<<<< HEAD

=======
  
>>>>>>> 5321bcb4f0fa6850e7efeb776d1e86c9c65f9868
  get 'user/index'
  get 'user/new'
  get 'user/show'
  get 'user/update'
  get 'user/destroy'
  get 'user/edit'
  get 'user/create'

  resources :products
  resources :category, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
