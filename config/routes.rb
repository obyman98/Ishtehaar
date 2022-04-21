Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"
  post "/create", to: "users#create"
  get "/auto_login", to: "users#auto_login"
  post 'passwords/forgot', to: 'passwords#forgot'
  post 'passwords/reset', to: 'passwords#reset'
  post 'ads/create', to: 'ads#create'
  post 'ads/all', to: 'ads#get'
  post 'ads/pending', to: 'ads#pending'
  post 'ads/approved', to: 'ads#approved'
  post 'ads/rejected', to: 'ads#rejected'
  post 'ads/update', to: 'ads#update'
end