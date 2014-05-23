Ping::Application.routes.draw do
  root 'pingas#index'
  resources :pingas
  resources :users

  match 'sessions/new', to: 'sessions#new', via: [:get]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:delete]
end
