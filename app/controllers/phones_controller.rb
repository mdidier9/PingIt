class PhonesController < ApplicationController
skip_before_filter :require_login, :only => [:recieve_request_get_events, :recieve_request_create_event, :recieve_request_register_rsvp_info, :check_for_user, :set_radius] 

	respond_to :json

	def set_radius
		uid = params[:data][:uid]
		# radius = params[:data][:radius]
		@user = User.find_by_uid(uid)
		# @user.listening_radius = radius
		# @user.save
		@check_hash = {radius_set_to: @user.listening_radius, for_this_person: @user.name} 
		respond_with @check_hash
	end

	def recieve_request_get_events
		@user = User.find_by_uid(params[:data][:uid])
		@user.latitude = params[:data][:latitude]
		@user.longitude = params[:data][:longitude]
		@user.save


	#-----------------------------------------------------------------updating attending status based on rsvp
	#TODO
	#-----------------------------------------------------------------------------------------------------	

		@user.update_user_pingas

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
		# @pinga.dispatch_from_phone
    WebsocketRails[:pingas].trigger('new_from_phone', {marker: { :id         => @pinga.id,
                                                                 :latitude   => @pinga.latitude,
                                                                 :longitude  => @pinga.longitude,
                                                                 :category   => @pinga.category.title,
                                                                 :infowindow => render_to_string(:partial => "/shared/infowindow", :locals => { pinga: @pinga }),
                                                                 :drop => true
                                                               }
    }.to_json)
    @pinga.put_in_queue
    # WebsocketRails[:pingas].trigger('phone', {id: @pinga.id, status: @pinga.status, category: @pinga.category.title}.to_json)

    # broadcast_message :phone, {marker: "hello"}

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

	#---------------------------------------------------------updating rsvp status upon button push
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
	#-------------------------------------------------------------------------------------------

		respond_with params
	end 


end


	

