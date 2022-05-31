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
  post 'ads/edit', to: 'ads#edit'
  post 'ads/edit', to: 'ads#assign'
  post 'vehicles/create', to: 'vehicles#create'
  post 'vehicles/pending', to: 'vehicles#pending'
  post 'vehicles/approved', to: 'vehicles#approved'
  post 'vehicles/rejected', to: 'vehicles#rejected'
  post 'vehicles/update', to: 'vehicles#update'
  post 'vehicles/get', to: 'vehicles#get'
  post 'vehicles/edit', to: 'vehicles#edit'
  post 'companies/create', to: 'companies#create'
  post 'eld/create', to: 'elds#create'
  post 'eld/get', to: 'elds#get'
  post 'eld/get', to: 'elds#show'
end
