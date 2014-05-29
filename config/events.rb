WebsocketRails::EventMap.describe do
  namespace :pingas do
    subscribe :create, :to => TaskController, :with_method => :create
    subscribe :destroy, :to => TaskController, :with_method => :destroy
    subscribe :update, :to => TaskController, :with_method => :update
    subscribe :new_from_phone, :to => TaskController, :with_method => :new_from_phone
  end
end