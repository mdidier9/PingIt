require 'spec_helper'

describe UsersController do
	let!(:user) {User.create!(uid: 1, listening_radius: 1, ip_address: "74.122.9.196", latitude: 41.8876, longitude: -87.6368)}
 
 	describe "update" do
 		it "updates a users pingas?" do
 			session = {session: {user_id: "1"}}
 			params = {params: {latitude: 41.8876, longitude: -87.6368}}
			get(:update, session.merge(format: :json), params.merge(format: :json))
			output = "<html><body>You are being <a href=\"http://test.host/sessions/new\">redirected</a>.</body></html>"
			expect(response.body).to eq(output)	 	
		end

 		it "updates a users pingas?" do
 			session = {session: {user_id: "1"}}
 			params = {params: {listening_radius: 1, latitude: 41.8876, longitude: -87.6368}}
			get(:update, session.merge(format: :json), params.merge(format: :json))
			output = "<html><body>You are being <a href=\"http://test.host/sessions/new\">redirected</a>.</body></html>"
			expect(response.body).to eq(output)	 	
		end

 	end

end
