class PhonesController < ApplicationController

	def recieve_request_get_events
		p "THIS IS INSIDE GET EVENTS ACTION ********************"
		p params #not sure there is even going to be params
		all_pingas = Pinga.all
		p all_pingas[0]
		return all_pingas.to_json
	end


	def recieve_request_create_event
		p "THIS IS INSIDE CREATE EVENT ACTION ********************"
		p params[:data]




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
    #NO (get from the phone using bubblewraps's location obj)   t.float     :latitude
    #NO (get from the phone using bubblewraps's location obj)   t.float     :longitude
    #NO (need to somehow get the user information from the phone) 	t.integer 	:creator_id #user_id
    #CHECK   t.timestamps (this will be created when it is entered in the database)



    #QUESTIONS
    #---------------------------------------------------------------------------------
    #How do we want to sanitize data? (trailing space?, newline? ) 
	end

end
