WebsocketRails::EventMap.describe do
  namespace :pingas do
    subscribe :create, :to => TaskController, :with_method => :create
    subscribe :destroy, :to => TaskController, :with_method => :destroy
    subscribe :update, :to => TaskController, :with_method => :update
  end
end