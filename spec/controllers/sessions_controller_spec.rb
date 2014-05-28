require 'spec_helper'

describe SessionsController do
	it "should redirect if a new pinga is not created and saved" do
    	get :destroy
    	expect(session[:user_id]).to eq(nil)
			response.should redirect_to'/'
   end

end
