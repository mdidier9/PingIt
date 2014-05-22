# Needs status
User.destroy_all
Pinga.destroy_all

User.create!()
User.create!()
User.create!()
User.create!()

Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now, end_time: Time.now, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 1)

Pinga.create!(title: "Sport town", description: "Play the game", status: "active", start_time: Time.now, end_time: Time.now, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 2)

Pinga.create!(title: "Drinkos", description: "We're at a bar", status: "active", start_time: Time.now, end_time: Time.now, address: "155 W Kinzie St, Chicago, IL 60654", creator_id: 3)