class CreateUserPingas < ActiveRecord::Migration
  def change
    create_table :user_pingas do |t|
    	t.integer  :user_id
    	t.integer  :pinga_id
    	t.string	 :rsvp_status
    	t.string	 :attend_status
      t.timestamps
    end
  end
end
