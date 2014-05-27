require 'spec_helper'

describe PingasController do
  describe "create index" do
    it "should redirect if a new pinga is not created and saved" do
    	post :create
			response.status.should eq 302
    end

    it "should redirect if a pinga is not deleted" do
    	post :create
			response.status.should eq 302
    end
  end
end