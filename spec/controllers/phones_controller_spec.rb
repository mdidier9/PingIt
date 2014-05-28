require 'spec_helper'

describe PhonesController do
   let!(:user) {User.create!(uid: 1, listening_radius: 1, ip_address: "74.122.9.196", latitude: 41.8876, longitude: -87.6368)}

	context "receive request get events" do
		it "does something with phone" do
   		data = {data: {uid: 1, oauth_expires_at: Time.now, oauth_token: 1, name: "name", provider: "facebook" }}
			get(:recieve_request_get_events, data)
			response.status.should eq 200
		end
	end

	# context "receive request create events" do
	# 	it "does something with phone" do
 #   		data = {data: {uid: 1, oauth_expires_at: Time.now, oauth_token: 1, name: "name", provider: "facebook" }}
	# 		get(:recieve_request_create_events, data)
	# 		response.status.should eq 200
	# 	end
	# end

end
