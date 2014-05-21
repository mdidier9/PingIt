Ping::Application.routes.draw do
  root 'pingas#index'
  resources :pingas
  resources :sessions
  resources :users
end
