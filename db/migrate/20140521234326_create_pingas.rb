class CreatePingas < ActiveRecord::Migration
  def change
    create_table :pingas do |t|
    	t.string 		:title
    	t.string 		:description
    	t.string 		:status
    	t.datetime 	:start_time
    	t.datetime 	:end_time
    	t.string		:address
    	t.integer		:location_id
    	t.integer 	:creator_id #user_id
      t.timestamps
    end
  end
end
