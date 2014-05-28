require 'spec_helper'

describe Pinga do
  it { should belong_to(:creator) }
  it { should have_many(:user_pingas) }
  it { should have_many(:users).through(:user_pingas) }

  let!(:category) {Category.create(title: "test category")}
  let!(:pinga) {Pinga.create(title: "Title", description: "desc", status: "pending", start_time: Time.now, duration: 4, end_time: Time.now+1000, address: "address here", latitude: 80.423542, longitude: 400.854903543, creator_id: 5, category: category)}
  let!(:pinga_expired) {Pinga.create(title: "Title 2", description: "desc 2", status: "pending", start_time: Time.now, duration: 0, end_time: Time.now, address: "address here", latitude: 80.423542, longitude: 400.854903543, creator_id: 5, category: category)}

  it "should be invalid without a title" do
    pinga.title = nil
    pinga.should_not be_valid
  end

  it "should be invalid without a description" do
    pinga.description = nil
    pinga.should_not be_valid
  end

  it "should have a status of 'pending', 'active', or 'inactive'" do
    ["pending", "active", "inactive"].each do |status|
      pinga.status = status
      pinga.should be_valid
    end
  end

  it "should have an address" do
    pinga.address = nil
    pinga.should_not be_valid
  end

  context "perform" do
    it "should be active for an event with an end time that didn't occur yet" do
      pinga.perform
      expect(pinga.status).to eq("active")
    end

    it "should be expired for an event with a end time after now" do
      pinga_expired.perform
      expect(pinga_expired.status).to eq("expired")
    end
  end
end
