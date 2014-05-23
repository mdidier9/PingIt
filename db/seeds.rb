# Needs status
User.destroy_all
Pinga.destroy_all

User.create!(listening_radius: 0.3, ip_address: "74.122.9.196")
User.create!(listening_radius: 0.3, ip_address: "74.122.9.196")

# out of range
Pinga.create!(title: "Sport town", description: "Play the game", status: "pending", start_time: Time.now, end_time: Time.now, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 2)

# in range
Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now, end_time: Time.now, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 1)
Pinga.create!(title: "Drinkos", description: "We're at a bar", status: "pending", start_time: Time.now, end_time: Time.now, address: "155 W Kinzie St, Chicago, IL 60654", creator_id: 3)
