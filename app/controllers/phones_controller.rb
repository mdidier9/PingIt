class PhonesController < ApplicationController
skip_before_filter :require_login, :only => [:recieve_request_get_events, :recieve_request_create_event] #add the phone controller pages in here

	respond_to :json

	def recieve_request_get_events
		p "THIS IS INSIDE GET EVENTS ACTION ********************"
		# p params #not sure there is even going to be params
		
		@pinga_array = []

		# all_pingas_array = Pinga.all
		Pinga.all.each_with_index do |ping_obj, index|
			@pinga_array.push(ping_obj.attributes)
		end
		# @pinga_hash[1] = {1 => "this", 2 => "huh"}
		# @pinga_hash[2] = {2 => "what"}

		# p @pinga_array
		respond_with @pinga_array
	end


	def recieve_request_create_event
		p "THIS IS INSIDE CREATE EVENT ACTION ********************"

		#geocode it with geocode gem (look for a method that can allow me to convert the address to the to the lat long)
		@confirm_response = "YES: YOU CONTACTED THE CREATE_EVENT ACTION IN THE PHONESCONTROLLER"
		
		@data = params[:data]





		@pinga = Pinga.new
		@pinga.title = @data[:title]
		@pinga.status = "pending" #THIS IS HARDCODED (this needs to be checked agianst the start time)
		puts "THIS IS THE CATEGORY ID I SHOULD GET BASED ON THE CATEGORY I CHOOSE ON THE PHONE"
		p Category.find_by_title(@data[:category]).id
		@pinga.category_id = Category.find_by_title(@data[:category]).id
		@pinga.description = @data[:description]
		@pinga.start_time = @data[:start_time]
		@pinga.end_time = @data[:end_time]
		@pinga.address = @data[:address]
		@pinga.creator_id = 1 #THIS IS HARDCODED
		@pinga.save
		p @pinga

		respond_with @data

		#NOTE: USER MUST BE HARDCODED UNTIL AUTH IS ESTABLISHED


		# valid_start_time = Time.now + 12.hours
  #   p params
  #   puts "X"*50
  #   p valid_start_time
  #   p params
  #   puts "X"*50
  #   @user = User.find(session[:user_id])
  #   @pinga = Pinga.new(title: params["pinga"]["title"])
  #   @pinga.status = "pending" # this needs to be checked against the start time
  #   @pinga.category_id = params["pinga"]["category_id"]
  #   @pinga.description = params["pinga"]["description"]
  #   @pinga.start_time = params["pinga"]["start_time"]
  #   @pinga.end_time = params["pinga"]["end_time"]
  #   @pinga.address = params["pinga"]["address"]
  #   @pinga.creator = @user





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

end
