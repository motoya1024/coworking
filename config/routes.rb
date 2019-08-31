Rails.application.routes.draw do
  root 'tops#home'
  get '/signup', to: 'users#new'
  get 'operations/edit', to: 'operations#edit'
  get 'operations/update', to: 'operations#update'
  
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
end
