Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"
  post "/create", to: "users#create"
  get "/auto_login", to: "users#auto_login"
  post 'passwords/forgot', to: 'passwords#forgot'
  post 'passwords/reset', to: 'passwords#reset'
  post 'ads/create', to: 'ads#create'
  post 'ads/all', to: 'ads#get'
end