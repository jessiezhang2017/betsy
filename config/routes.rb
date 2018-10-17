Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'orders/create'
  get 'orders/edit'
  get 'orders/update'
  get 'user/index'
  get 'user/new'
  get 'user/show'
  get 'user/update'
  get 'user/destroy'
  get 'user/edit'
  get 'user/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
