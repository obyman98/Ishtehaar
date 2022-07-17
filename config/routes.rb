Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"
  post "/create", to: "users#create"
  get "/auto_login", to: "users#auto_login"
  post "/show", to: "users#show"
  post "/drivers", to: "users#drivers"
  post "/update", to: "users#update"
  post "/toggle", to: "users#toggle"
  post "/get", to: "users#get"
  post 'passwords/forgot', to: 'passwords#forgot'
  post 'passwords/reset', to: 'passwords#reset'
  post 'passwords/update', to: 'passwords#update'
  post 'ads/create', to: 'ads#create'
  post 'ads/all', to: 'ads#get'
  post 'ads/pending', to: 'ads#pending'
  post 'ads/approved', to: 'ads#approved'
  post 'ads/rejected', to: 'ads#rejected'
  post 'ads/update', to: 'ads#update'
  post 'ads/edit', to: 'ads#edit'
  post 'ads/assign', to: 'ads#assign'
  post 'ads/get', to: 'ads#get'
  post 'vehicles/create', to: 'vehicles#create'
  post 'vehicles/pending', to: 'vehicles#pending'
  post 'vehicles/approved', to: 'vehicles#approved'
  post 'vehicles/rejected', to: 'vehicles#rejected'
  post 'vehicles/update', to: 'vehicles#update'
  post 'vehicles/get', to: 'vehicles#get'
  post 'vehicles/edit', to: 'vehicles#edit'
  post 'companies/create', to: 'companies#create'
  post 'companies/get', to: 'companies#get'
  post 'companies/user', to: 'companies#user'
  post 'eld/create', to: 'elds#create'
  post 'events/create', to: 'events#create'
  post 'events/query', to: 'events#query'
end
