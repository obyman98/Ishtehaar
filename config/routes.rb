Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"
  post "/create", to: "users#create"
  get "/auto_login", to: "users#auto_login"
end