class PhonesController < ApplicationController
skip_before_filter :require_login, :only => [:recieve_request_get_events, :recieve_request_create_event, :recieve_request_register_rsvp_info, :check_for_user, :set_radius] 

	respond_to :json

	def set_radius
		uid = params[:data][:uid]
		radius = params[:data][:radius]
		@user = User.find_by_uid(uid)
		@user.listening_radius = radius
		@user.save
		@check_hash = {radius_set_to: @user.listening_radius, for_this_person: @user.name} 
		respond_with @check_hash
	end

	def recieve_request_get_events
		p "THIS IS INSIDE GET EVENTS ACTION ********************"

		@user = User.find_by_uid(params[:data][:uid])
		@user.latitude = params[:data][:latitude]
		@user.longitude = params[:data][:longitude]
		@user.save

		@user.update_user_pingas
		"ALL USER PINGAS (update_user_pingas)"
		p @user.pingas 

		pingas_active_near = @user.active_pingas_in_listening_radius
		pingas_pending_near = @user.pending_pingas_in_listening_radius
		pingas_far = @user.pingas_outside_listening_radius
		
		@pinga_hash = {pingas_active_in_radius: [], pingas_pending_in_radius: [], pingas_outside_radius: []}
		

		pingas_active_near.each_with_index do |ping_obj, index|
			(@pinga_hash[:pingas_active_in_radius]).push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		end

		pingas_pending_near.each_with_index do |ping_obj, index|
			(@pinga_hash[:pingas_pending_in_radius]).push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		end

		pingas_far.each_with_index do |ping_obj, index|
			@pinga_hash[:pingas_outside_radius].push(ping_obj.attributes.merge('start_time' => ping_obj.start_time.strftime('%Y-%m-%d %H:%M:%S %z'), 'end_time' => ping_obj.end_time.strftime('%Y-%m-%d %H:%M:%S %z'))) #add more keys and values for time paramters
		end				

		respond_with @pinga_hash
	end



	def recieve_request_create_event
		p "THIS IS INSIDE CREATE EVENT ACTION ************************************************************************************"
		
		@data = params[:data]
		@user = User.find_by_uid(@data[:uid])
		@pinga = Pinga.new
		@pinga.title = @data[:title]
		#@pinga.status = "pending" #SHOULD NOT NEED TO HARDCODE IF DELAYED JOBS IS WORKING
		@pinga.category_id = Category.find_by_title(@data[:category]).id
		@pinga.description = @data[:description]
		@pinga.address = @data[:address] #WHAT IF THE ADDRESS IS INCORRECT (do we need validations on the phone?)
		@pinga.duration = @data[:duration]

#---------------------------------------------------------------------------creating pinga.start_time
		selected_hour = ((/^\d+/.match(@data[:start_time]))[0]).to_i
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
#---------------------------------------------------------------------------------------------------
		@pinga.creator_id = @user.id 	
		@pinga.save

#-------------------------------------------------------creating user_pinga
		user_pinga = UserPinga.new
		user_pinga.user = @user
		user_pinga.pinga = @pinga
		user_pinga.rsvp_status = "creator"
		user_pinga.attend_status = "creator"
		user_pinga.save  
#------------------------------------------------------------------------------


		@pinga.creator_id = 1 #THIS IS HARDCODED (need have some information about the user somewhere at login)
		@pinga.save
    WebsocketRails[:pingas].trigger('update', {id: @pinga.id, status: @pinga.status, category: @pinga.category.title}.to_json)
		puts "THIS IS THIS THE CREATED EVENT"

		p @pinga
		puts "THIS IS THE USER"
		p @user
		puts "THIS IS THE USER_PINGA"
		p user_pinga 

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

def recieve_request_register_rsvp_info
	puts "INSIDE RSVP REQUEST"
	p params[:data][:uid]
	p params[:data][:rsvp_status]
	p params[:data][:event_id]

	user = User.find_by_uid(params[:data][:uid])
	pinga = Pinga.find_by_id(params[:data][:event_id])
	user_pinga = UserPinga.where(user_id: user.id ,pinga_id: pinga.id)
	p user_pinga 


	unless user_pinga.rsvp_status == "creator"
		if params[:rsvp_status] == "attending"
			user_pinga.rsvp_status = params[:rsvp_status]
		else
			user_pinga.rsvp_status = nil
		end
		user_pinga.save
		p "THIS USER_PINGA IS NOT FOR A CREATOR"
		p user_pinga
	end

	respond_with params
end 

  # def update
  #   user_pinga = UserPinga.find(params[:id])
  #   if params[:rsvp_status] == "attending"
  #     user_pinga.rsvp_status = params[:rsvp_status]
  #   else
  #     user_pinga.rsvp_status = nil
  #   end
  #   user_pinga.save

  #   if user_pinga.rsvp_status == "attending"
  #     render json: {attending: true}
  #   else
  #     render json: {attending: false}
  #   end
  # end


end

#------------------------------------------------------------------------------------------------------
#USE THIS TO CREATE RELATIONSHIP BETWEEN PINGAS AND USERS IN RANGE

 # def update_user_pingas
 #    Pinga.near(self, self.listening_radius).where(status: ["pending", "active"]).each do |pinga|
 #      self.pingas << pinga unless self.pingas.include?(pinga)
 #    end
 #    self.save
 #  end

 #USE THIS TO CREATE RELATIONSHIP BETWEN PINGAS AND CREATORS
  #  def create
  #   user = User.find(session[:user_id])
  #   pinga = Pinga.new
  #   pinga.title = message["pinga[title]"]
  #   pinga.category_id = message["pinga[category_id]"]
  #   pinga.description = message["pinga[description]"]
  #   pinga.address = message["pinga[address]"]
  #   pinga.duration = message["duration"].to_i
  #   pinga.start_time = Time.parse("#{message[:today]} #{message["pinga[start_time]"]}")
  #   pinga.creator = user
  #   pinga.save

  #   user_pinga = UserPinga.new
  #   user_pinga.user = user
  #   user_pinga.pinga = pinga
  #   user_pinga.rsvp_status = "creator"
  #   user_pinga.attend_status = "creator"
  #   user_pinga.save

  #   pinga_marker = create_marker(pinga, user)
  #   broadcast_message :new, {marker: pinga_marker}, :namespace => 'pingas'
  # end
#-----------------------------------------------------------------------------------------------------

  


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
	

