#PingIt

###Events - When and Where they matter most

[![Coverage Status](https://coveralls.io/repos/mdidier9/Ping/badge.png?branch=master)](https://coveralls.io/r/mdidier9/Ping?branch=master)              [![Build Status](https://travis-ci.org/mdidier9/Ping.svg?branch=master)](https://travis-ci.org/mdidier9/Ping)


Mobile Application Gihtub: [PingIt Mobile](https://github.com/rmathur101/PingMobile)

#####Team PingIt
  * [Dan Armstrong](https://github.com/wtfdaboo)
  * [Rohan Mathur](https://github.com/rmathur101)
  * [Tam Dang](https://github.com/teedang19)
  * [Ron Gierlach](https://github.com/rongierlach)
  * [Matt Didier](https://github.com/mdidier9)

*****
"PingIt" is a Ruby on Rails web application complemented by a Ruby Motion iOS mobile application.

The purpose of PingIt is to offer a platform for people to create and find events of particular interest.  PingIt is specifically designed for events that occur "here and now".  An event can only be created if it occurs within the next 12 hours.  This feature makes it incredibly simple to find events that are occurring in the immediate short term.  Finally, there is an answer to the question, "What do you want to do tonight?!"

PingIt is different from other event planning/finding apps.  PingIt allows users to filter events that are of interest to them by specific categories in addition to offering the user the opportunity to specify their "listening radius".  The user's listening radius can range from 1/4 mile to 20 miles and only displays the events located in the specified proximity to the user.

Events perfect for PingIt:
  1. Pick-up sports games
  2. Spontaneous concerts or jam sessions
  3. Protests
  4. House parties
  5. Flash mobs
  6. Food trucks
  7. Short-term deals or give-aways
  8. and many other social gatherings

A final feature that PingIt offers is the ability for an event creator to determine who attended an event.  If a user RSVP's for an event and is logged in to PingIt on their iOS device when arriving to an event, their presence will be logged by the PingIt servers.  This feature is not complete but if we had another day we would have loved to fully integrate it.

*****

####Spotlighted Technologies:
  * Ruby on Rails
  * Ruby Motion
  * Heroku
  * PostgreSQL
  * Redis
  * Facebook Omniauth
  * Google Maps
  * Geocoder
  * Websocket
  * Bubble-Wrap

*****

redis-server /usr/local/etc/redis.conf

rake jobs:work
