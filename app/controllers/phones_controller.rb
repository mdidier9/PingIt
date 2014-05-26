class PhonesController < ApplicationController
skip_before_filter :require_login, :only => [:recieve_request_get_events, :recieve_request_create_event] #add the phone controller pages in here

	respond_to :json

	def recieve_request_get_events
		p "THIS IS INSIDE GET EVENTS ACTION ********************"
		@pinga_array = []

		Pinga.all.each_with_index do |ping_obj, index|
			@pinga_array.push(ping_obj.attributes)
		end
		p @pinga_array
		respond_with @pinga_array
	end


	def recieve_request_create_event
		p "THIS IS INSIDE CREATE EVENT ACTION ********************"
		
		@data = params[:data]
		# p "THIS IS THE PINGA INFO"
		@pinga = Pinga.new
		@pinga.title = @data[:title]
		# p @data[:title]
		@pinga.status = "pending" #THIS IS HARDCODED (this needs to be checked agianst the start time)
		p Category.find_by_title(@data[:category]).id
		@pinga.category_id = Category.find_by_title(@data[:category]).id
		@pinga.description = @data[:description]
		# p @data[:description]
		@pinga.start_time = @data[:start_time]
		# p @data[:start_time]
		@pinga.duration = @data[:duration]
		# p @data[:duration]
		@pinga.address = @data[:address] #WHAT IF THE ADDRESS IS INCORRECT (do we need validations on the phone?)
		# p @data[:address]
		@pinga.creator_id = 1 #THIS IS HARDCODED (need have some information about the user somewhere at login)
		@pinga.save
		p @pinga
		respond_with @data
	end

	def recieve_request_register_rsvp_info
		p "THIS IS INSIDE REGISTER RSVP ACTION"
		p params
	end

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
    #NO (get from the the address)   t.float     :longitude
    #NO (need to somehow get the user information from the phone; maybe whenever someone logs in on the phone app there needs to be a way to send the registration information so that the user ends up in the dabatabse connected to the web app) 	t.integer 	:creator_id #user_id
    #CHECK   t.timestamps (this will be created when it is entered in the database)

    #QUESTIONS
    #---------------------------------------------------------------------------------
    #How do we want to sanitize data? (trailing space?, newline? ) 
	

end
