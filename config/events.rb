WebsocketRails::EventMap.describe do
  namespace :tasks do
    subscribe :create, :to => TaskController, :with_method => :create
    subscribe :destroy, :to => TaskController, :with_method => :destroy
  end
end