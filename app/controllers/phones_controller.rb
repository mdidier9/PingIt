class PhonesController < ApplicationController
skip_before_filter :require_login, :only => [:recieve_request_get_events, :recieve_request_create_event] #add the phone controller pages in here

	respond_to :json

	def recieve_request_get_events
		p "THIS IS INSIDE GET EVENTS ACTION ********************"
		# p params #not sure there is even going to be params
		
		@pinga_hash = {}

		# Pinga.all.each_with_index do |ping_obj, index|
		# 	pinga_hash[index] = ping_obj
		# end
		@pinga_hash[1] = {1 => "this", 2 => "huh"}
		@pinga_hash[2] = {2 => "what"}

		p @pinga_hash
		respond_with @pinga_hash
	end


	def recieve_request_create_event
		p "THIS IS INSIDE CREATE EVENT ACTION ********************"

		#geocode it with geocode gem (look for a method that can allow me to convert the address to the to the lat long)

		@create_event_data = params[:data]

		p @create_event_data

		respond_with @create_event_data



		#TO DO
		#---------------------------------------------------------------------------

		#this is currently the format of the new_ping hash that we are getting from the phone
		#----------------------------------------------------------------------------------------
		# {"title"=>"", "description"=>"", "category"=>"Social", "start_time"=>"6:00 PM", "end_time"=>"8:00 PM", "address"=>""}  



		#this is currently the format of the new_ping properties that is defined in our migrations
		#----------------------------------------------------------------------------------------
		
		#CHECK 	t.string 		:title 
    #CHECK 	t.string 		:description
    #NO (determine in web app --- method) 	t.string 		:status            
    #CHECK 	t.datetime 	:start_time
    #CHECK 	t.datetime 	:end_time
    #CHECK 	t.string		:address
    #NO (get from the the address)   t.float     :latitude
    #NO (get from the phone using bubblewraps's location obj)   t.float     :longitude
    #NO (need to somehow get the user information from the phone) 	t.integer 	:creator_id #user_id
    #CHECK   t.timestamps (this will be created when it is entered in the database)



    #QUESTIONS
    #---------------------------------------------------------------------------------
    #How do we want to sanitize data? (trailing space?, newline? ) 
	end

end
