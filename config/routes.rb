Rails.application.routes.draw do
  namespace :admin do
    resource :dashboard, only: [:show]
  end

  resources :families, only: [:index, :show]

  resources :users, only: [:new, :create]

  resources :cart, only: [:index] 

  resources :cart_items, only: [:create, :update, :destroy]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: "users#show"

  get '/donations', to: "donations#index"

  root to: "families#index"

  resources :categories, only: [:show], path: ""
end
