require 'spec_helper'

describe PhonesController do
   let!(:user) {User.create!(uid: 1, listening_radius: 1, ip_address: "74.122.9.196", latitude: 41.8876, longitude: -87.6368)}
   let!(:category) {Category.create!(title: "test")}

	context "receive request get events" do
		it "does something with phone" do
   		data = {data: {uid: "1", oauth_expires_at: Time.now, oauth_token: 1, name: "name", provider: "facebook", latitude: 41.8876, longitude: -87.6368 }}
			get(:recieve_request_get_events, data.merge(format: :json))
			pinga_hash = {"pingas_active_in_radius"=>[], "pingas_pending_in_radius"=>[], "pingas_outside_radius"=>[]}
			expect(JSON.parse(response.body)).to include(pinga_hash)
		end
	end

	context "set_radius" do
		it "sets radius of user" do
	  	data = {data: {uid: "1", oauth_expires_at: Time.now, oauth_token: 1, name: "name", provider: "facebook", latitude: 41.8876, longitude: -87.6368 }}
			get(:set_radius, data.merge(format: :json))
			check_hash = {"for_this_person" => nil, "radius_set_to" => 1.0}
			expect(JSON.parse(response.body)).to include(check_hash)
		end
	end

	context "receive request create event" do
		it "should create an event" do
			# data = {data: {title: "title", category: category.title, start_time: "12", duration: 4}}
			# get(:recieve_request_create_event, data.merge(format: :json))
			# new_data = {"category" => "test", "duration" => 4, "start_time" => "12", "title" => "title"}
			# expect(JSON.parse(response.body)).to include(new_data)
		end
	end	

	context "check for user" do
		it "checks for the existence of a valid user in the db" do
			data = {data: {uid: "1"}}
			get(:check_for_user, data.merge(format: :json))
			bool_hash = {"user_exists" => "true"}
			expect(JSON.parse(response.body)).to include(bool_hash)
		end

		it "checks for the existence of a user in the db and creates a new one" do
			data = {data: {uid: "2"}}
			get(:check_for_user, data.merge(format: :json))
			bool_hash = {"user_exists" => "new user created"}
			expect(JSON.parse(response.body)).to include(bool_hash)
		end
	end

end
