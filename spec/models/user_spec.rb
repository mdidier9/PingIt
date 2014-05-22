require 'spec_helper'

describe User do
  before :each do
    user = User.create!(listening_radius: 0.3, ip_address: "74.122.9.196")
    grey = Pinga.create!(title: "Sport town", description: "Play the game", status: "pending", start_time: Time.now, end_time: Time.now, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 2)
    active = Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now, end_time: Time.now, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 1)
    pending = Pinga.create!(title: "Drinkos", description: "We're at a bar", status: "pending", start_time: Time.now, end_time: Time.now, address: "155 W Kinzie St, Chicago, IL 60654", creator_id: 3)

  end
  context "user associations" do
    it { should have_many(:created_pingas) }
    it { should have_many(:user_pingas) }
    it { should have_many(:pingas).through(:user_pingas) }
  end

  context "active_pingas_in_listening_radius" do
    it "should return active pingas in listening radius" do
      expect (user.active_pingas_in_listening_radius).to eq([active])
    end
  end

  context "active_pinga_markers" do
    it "should return Gmaps4rails object" do
      # expect(user.active_pinga_markers).to
    end


  end





end
