WebsocketRails::EventMap.describe do
  namespace :tasks do
    subscribe :create, :to => TaskController, :with_method => :create
  end
end