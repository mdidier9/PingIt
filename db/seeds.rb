# Categories
food = Category.find_by_title("Food")
social = Category.find_by_title("Social")
sports = Category.find_by_title("Sports")
entertainment = Category.find_by_title("Entertainment")
deals = Category.find_by_title("Deals")
other = Category.find_by_title("Other")

# Needs status
User.destroy_all
Pinga.destroy_all

# out of range
Pinga.create!(title: "Sport town", description: "Play the game", status: "pending", start_time: Time.now+1000, address: "630 N Kingsbury St Chicago, IL 60654", creator_id: 1, category: sports, duration: 1)

# in range
Pinga.create!(title: "Food Truck", description: "There is food.", status: "active", start_time: Time.now-600, address: "351 W Hubbard St, Chicago, IL 60654", creator_id: 1, category: food, duration: 1)

Pinga.create!(title: "Chipotile $1 Burritos", description: "This is crazy", status: "pending", start_time: Time.now+6000, address: "233 W Lake St Chicago, IL 60606", creator_id: 1, category: food, duration: 1)

Pinga.create!(title: "Subway 20$ footlongs", description: "Which one is this again?", status: "active", start_time: Time.now-1000, address: "304 W Hubbard St Chicago, IL 60654", creator_id: 1, category: deals, duration: 1)

Pinga.create!(title: "Three dots and a dash", description: "This sounds like a bar", status: "active", start_time: Time.now-500, address: "435 N Clark St Chicago, IL 60654", creator_id: 1, category: entertainment, duration: 1)

Pinga.create!(title: "Flash Mob", description: "I don't get these things", status: "pending", start_time: Time.now+500, address: "220 E Chicago Ave Chicago, IL 60611", creator_id: 1, category: social, duration: 1)

Pinga.create!(title: "Rubies meets up", description: "'Grammin at a hotel", status: "pending", start_time: Time.now+1000, address: "111 W Huron St Chicago, IL 60654", creator_id: 1, category: social, duration: 1)

Pinga.create!(title: "Stake out", description: "Strange building - lets look at it", status: "pending", start_time: Time.now+300, address: "182 W Lake St Chicago, IL 60601", creator_id: 1, category: social, duration: 1)

Pinga.create!(title: "Other Title", description: "Other Description", status: "pending", start_time: Time.now+1000, address: "1000 West Washington Ave, Chicago, IL", creator_id: 1, category: other, duration: 1)