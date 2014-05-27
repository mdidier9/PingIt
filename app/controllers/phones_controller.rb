class PhonesController < ApplicationController
skip_before_filter :require_login, :only => [:recieve_request_get_events, :recieve_request_create_event, :recieve_request_register_rsvp_info, :check_for_user] 

	respond_to :json

	def recieve_request_get_events
		p "THIS IS INSIDE GET EVENTS ACTION ********************"

		@user = User.find_by_uid(params[:data][:uid])
		@user.latitude = params[:data][:latitude]
		@user.longitude = params[:data][:longitude]
		@user.save

		pingas_active_near = @user.active_pingas_in_listening_radius
		pingas_pending_near = @user.pending_pingas_in_listening_radius
		pingas_far = @user.pingas_outside_listening_radius
		
		@pinga_hash = {pingas_active_in_radius: [], pingas_pending_in_radius: [], pingas_outside_radius: []}
		

		pingas_active_near.each_with_index do |ping_obj, index|
			(@pinga_array[:pingas_active_in_radius]).push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		end

		pingas_pending_near.each_with_index do |ping_obj, index|
			(@pinga_array[:pingas_pending_in_radius]).push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		end

		pingas_far.each_with_index do |ping_obj, index|
			@pinga_array[:pingas_outside_radius].push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		end				

		# Pinga.all.each_with_index do |ping_obj, index|
		# 	@pinga_array.push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		# end

		respond_with @pinga_hash
	end


	def recieve_request_create_event
		p "THIS IS INSIDE CREATE EVENT ACTION ********************"
		
		@data = params[:data]
		# p "THIS IS THE PINGA INFO"
		@pinga = Pinga.new
		@pinga.title = @data[:title]
		# p @data[:title]
		@pinga.status = "pending" #THIS IS HARDCODED (this needs to be checked agianst the start time)
		# p Category.find_by_title(@data[:category]).id
		@pinga.category_id = Category.find_by_title(@data[:category]).id
		@pinga.description = @data[:description]
		# p @data[:description]
		@pinga.address = @data[:address] #WHAT IF THE ADDRESS IS INCORRECT (do we need validations on the phone?)
		# p @data[:address]
		@pinga.duration = @data[:duration]

		# @pinga.start_time = @data[:start_time]


		selected_hour = ((/^\d+/.match(@data[:start_time]))[0]).to_i
		# if (/[P|p]/.match(@data[:start_time])) != nil
		selected_hour += 12 if (/[P|p]/.match(@data[:start_time]))
		current_hour = Time.now.hour
		last_valid_hour = current_hour - 11

		p "TIME NOW: #{Time.now}"
		p "THIS IS CURRENT HOUR #{current_hour}"
		p "THIS IS SELECTED HOUR #{selected_hour}" 
		p "THE LAST VALID HOUR: #{last_valid_hour}"

		if selected_hour > last_valid_hour && selected_hour < current_hour
			puts "THIS IS NOT A VALID TIME"
		end

		if selected_hour < current_hour
		 tomorrow = Date.today + 1
		 tomorrow_string = tomorrow.strftime("%a %b %d %Y") + " #{@data[:start_time]}"
		 @pinga.start_time = Time.parse(tomorrow_string)
		else
		 today_string = Date.today.strftime("%a %b %d %Y") + " #{@data[:start_time]}"
		 @pinga.start_time = Time.parse(today_string)
		end


		@pinga.creator_id = 1 #THIS IS HARDCODED (need have some information about the user somewhere at login)
		@pinga.save
		puts "THIS IS THIS THE CREATED EVENT"
		p @pinga
		respond_with @data
	end

	def check_for_user
		uid = params[:data][:uid] 
		user = User.find_by_uid(uid)
		@bool = "nothing"
		if user
			@bool = "true"
		else
			@user = User.new
			@user.oauth_token = params[:data][:oauth_token]
			@user.oauth_expires_at = params[:data][:oauth_expires_at]
			@user.name = params[:data][:name]
			@user.uid = params[:data][:uid]
			@user.provider = "facebook"
			@user.listening_radius = 1
			@user.save

			@bool = "new user created"
		end
		@bool_hash = {user_exists: @bool}
		respond_with @bool_hash
	end

end


  # create_table "users", force: true do |t|
  #   t.string   "oauth_token"
  #   t.datetime "oauth_expires_at"
  #   t.float    "latitude"
  #   t.float    "longitude"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.string   "name"
  #   t.string   "provider"
  #   t.string   "uid"
  #   t.string   "ip_address"
  #   t.float    "listening_radius"
  # end











=begin

# validate user has chosen a valid start time
	- convert selected_hour to military time # 17
		if /pm/.match(selectedhour)
			add 12 to the integer hour of the string (regex)
		else
			just grab the integer
	- (now selected_hour is an integer corresponding to military hour)
	- current_hour = Time.now.hour # already in military time # 18
	- last_valid_hour = current_hour - 11 # 7
	- if (selected_hour > last_valid_hour && selected_hour < current_hour)
			# INVALID
	- end


# send params to controller in correct format (so it can properly be parsed & saved to db)
	start_time => "6:00PM"
	if start_time.hour < current_time.hour
		date_string = tomorrow's date (in form of 'Mon Mar 26')
	else
		date_string = today's date (in form of 'Mon Mar 26')
	end

	params[:start_time] => "6:00PM"
	time_string = date_string + params[:start_time]
	Time.parse(time_string) # this will return the format you need to save to db


selected_hr = starttime.hr


if selected_hr <= now.hr 
	then we create a string with tomorrow's date ()
else

=end		


#start_time

#duration


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
	

