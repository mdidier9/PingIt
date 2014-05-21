class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string	 :oauth_token
    	t.datetime :oauth_expires_at
    	t.integer  :location_id
      t.timestamps
    end
  end
end
