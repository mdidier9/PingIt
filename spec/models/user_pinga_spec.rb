require 'spec_helper'

describe UserPinga do
  let(:pinga) {UserPinga.new(user_id: 1, pinga_id: 5, rsvp_status: "attending", attend_status: "attended")}
  it { should belong_to(:pinga) }
  it { should belong_to(:user) }

  it "should not be valid without a user id" do
    pinga.user_id = nil
    pinga.should_not be_valid
  end

  it "should not be valid without a pinga id" do
    pinga.pinga_id = nil
    pinga.should_not be_valid
  end

  it "should have an rsvp_status of 'attending', 'not attending', or nil" do
    pinga.rsvp_status = "potatoes"
    pinga.should_not be_valid

    ["attending", "not attending", nil].each do |status|
      pinga.rsvp_status = status
      pinga.should be_valid
    end
  end

  it "should have an attend_status of 'attended', 'did not attent', or nil" do
    pinga.attend_status = "potatoes"
    pinga.should_not be_valid

    ["attended", "did not attend", nil].each do |status|
      pinga.attend_status = status
      pinga.should be_valid
    end
  end
  
end
