# Needs status
User.destroy_all
Pinga.destroy_all

# out of range
Pinga.create!(title: "Sport town", description: "Play the game", status: "pending", start_time: Time.now+1000, end_time: Time.now, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 2)

# in range
Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now-600, end_time: Time.now, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 1)
Pinga.create!(title: "Chipotile $1 Burritos", description: "This is crazy", status: "pending", start_time: Time.now+6000, end_time: Time.now, address: "233 W Lake St Chicago, IL 60606", creator_id: 3)

Pinga.create!(title: "Subway 20$ footlongs", description: "Which one is this again?", status: "active", start_time: Time.now-1000, end_time: Time.now, address: "304 W Hubbard St Chicago, IL 60654", creator_id: 3)

Pinga.create!(title: "Three dots and a dash", description: "This sounds like a bar", status: "active", start_time: Time.now-500, end_time: Time.now, address: "435 N Clark St Chicago, IL 60654", creator_id: 3)

Pinga.create!(title: "Flash Mob", description: "I don't get these things", status: "pending", start_time: Time.now+500, end_time: Time.now, address: "220 E Chicago Ave Chicago, IL 60611", creator_id: 3)

Pinga.create!(title: "Rubies meets up", description: "'Grammin at a hotel", status: "pending", start_time: Time.now+1000, end_time: Time.now, address: "111 W Huron St Chicago, IL 60654", creator_id: 3)

Pinga.create!(title: "Stake out", description: "Strange building - lets look at it", status: "pending", start_time: Time.now+300, end_time: Time.now, address: "182 W Lake St Chicago, IL 60601", creator_id: 3)

