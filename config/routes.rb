Ping::Application.routes.draw do
  root 'events#index'
  resources :events
  resources :sessions
  resources :users
end
