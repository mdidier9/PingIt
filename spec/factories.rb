FactoryGirl.define do
  factory :user do
  	latitude 				 nil
  	longitude 			 nil
  	listening_radius nil
  	ip_address 			 nil
  end

  factory :pinga do
  	title 					 "title"
  	description 		 "description"
  	status 					 "pending"
  	start_time 			 nil
  	end_time 				 nil
  	address 				 "address"
  	latitude 				 nil
  	longitude 			 nil
  	creator_id 			 nil
  end

  factory :user_pinga do
  	user
  	pinga
  	rsvp_status			 nil
  	attend_status 	 nil
	end
end
