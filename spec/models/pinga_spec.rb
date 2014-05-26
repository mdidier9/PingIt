require 'spec_helper'

describe Pinga do
  it { should belong_to(:creator) }
  it { should have_many(:user_pingas) }
  it { should have_many(:users).through(:user_pingas) }

  let (:pinga) {Pinga.new(title: "Title", description: "desc", status: "pending", start_time: Time.new, duration: 4, address: "address here", latitude: 80.423542, longitude: 400.854903543, creator_id: 5, category_id: 1)}

  it "should be invalid without a title" do
    pinga.title = nil
    pinga.should_not be_valid
  end

  it "should be invalid without a description" do
    pinga.description = nil
    pinga.should_not be_valid
  end

  it "should have a status of 'pending', 'active', or 'inactive'" do
    pinga.status = "potatoes"
    pinga.should_not be_valid
    
    ["pending", "active", "inactive"].each do |status|
      pinga.status = status
      pinga.should be_valid
    end
  end

  it "should have an address" do
    pinga.address = nil
    pinga.should_not be_valid
  end
end
