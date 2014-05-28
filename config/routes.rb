Ping::Application.routes.draw do
  root 'pingas#index'
  resources :pingas
  resources :users
  resources :user_pingas, only:[:update]
  resources :user_categories, only:[:update]

  match 'sessions/new', to: 'sessions#new', via: [:get]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:delete]


  #connect to iphone
  match 'phone/get_events', to: 'phones#recieve_request_get_events', via: [:get]
  match 'phone/create_event', to: 'phones#recieve_request_create_event', via: [:get] 
  match 'phone/register_rsvp_info', to: 'phones#recieve_request_register_rsvp_info', via: [:get]
  match 'phone/checkforuser', to: 'phones#check_for_user', via: [:get]
  match 'phone/set_radius', to: 'phones#set_radius' via: [:get]
end
