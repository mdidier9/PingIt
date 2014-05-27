require 'spec_helper'

describe User do
    let!(:user) {User.create!(listening_radius: 0.3, ip_address: "74.122.9.196", latitude: 41.8876, longitude: -87.6368)}
    let!(:grey) {Pinga.create!(title: "Sport town", description: "Play the game", status: "pending", start_time: Time.now+100, duration: 4, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 3, category_id: 1, latitude: 41.8936415, longitude: -87.6419353)}
    let!(:active) {Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now, duration: 4, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 2, category_id: 2, latitude: 41.8899109, longitude: -87.6376566)}
    let!(:pending) {Pinga.create!(title: "Drinkos", description: "We're at a bar", status: "pending", start_time: Time.now+100, duration: 4, address: "155 W Kinzie St, Chicago, IL 60654", creator_id: 1, category_id: 3, latitude: 41.8888729, longitude: -87.6332098)}

  context "user associations" do
    it { should have_many(:created_pingas) }
    it { should have_many(:user_pingas) }
    it { should have_many(:pingas).through(:user_pingas) }
    it { should have_many(:user_categories)}
    it { should have_many(:categories).through(:user_categories)}
  end

  context "distance" do
    it "should return the distance from a user to a pinga" do 
      expect(user.distance(active)).to eq(0.17)
    end
  end

  context "active_pingas_in_listening_radius" do
    it "should return active pingas in listening radius" do
      expect(user.active_pingas_in_listening_radius).to eq([active])
    end
  end

  context "pending_pingas_in_listening_radius" do
    it "should return pending pingas in listening radius" do
      expect(user.pending_pingas_in_listening_radius).to eq([pending])
    end
  end

  context "pingas_outside_listening_radius" do
    it "should return pingas outside of user listening radius" do
      expect(user.pingas_outside_listening_radius).to eq([grey])
    end
  end

  context "update user pingas" do
    it "should update" do
      # while active.latitude == nil
      #   active.geocode
      # end
      # while pending.latitude == nil
      #   pending.geocode
      # end
      user.update_user_pingas
      expect(user.pingas.count).to eq(2)
    end
  end

  context "in listening radius of" do
    it "should return return true pinga is in listening radius of" do
      expect(user.in_listening_radius_of(active)).to eq(true)
    end
  end

end
