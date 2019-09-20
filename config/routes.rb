Rails.application.routes.draw do
  root 'tops#home'
  get '/signup', to: 'users#new'
  get 'operations/edit', to: 'operations#edit'
  patch 'operations/update', to: 'operations#update'
  
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    get "change_show", on: :member
    get 'edit_info', on: :member
    patch 'update_info', on: :member
    get 'edit_reservation', on: :member
    patch 'update_reservation', on: :member
    resources :reservations
  end 
end
