require 'spec_helper'

describe User do
    let!(:user) {User.create!(listening_radius: 0.3, ip_address: "74.122.9.196")}
    let!(:grey) {Pinga.create!(title: "Sport town", description: "Play the game", status: "pending", start_time: Time.now, end_time: Time.now, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 3)}
    let!(:active) {Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now, end_time: Time.now, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 2)}
    let!(:pending) {Pinga.create!(title: "Drinkos", description: "We're at a bar", status: "pending", start_time: Time.now, end_time: Time.now, address: "155 W Kinzie St, Chicago, IL 60654", creator_id: 1)}

  context "user associations" do
    it { should have_many(:created_pingas) }
    it { should have_many(:user_pingas) }
    it { should have_many(:pingas).through(:user_pingas) }
  end

  context "active_pingas_in_listening_radius" do
    it "should return active pingas in listening radius" do
      user.geocode
      expect(user.active_pingas_in_listening_radius).to eq([active])
    end
  end

  context "pending_pingas_in_listening_radius" do
    it "should return pending pingas in listening radius" do
      user.geocode
      expect(user.pending_pingas_in_listening_radius).to eq([pending])
    end
  end

  context "pingas_outside_listening_radius" do
    it "should return pingas outside of user listening radius" do
      user.geocode
      expect(user.pingas_outside_listening_radius).to eq([grey])
    end
  end

end
