# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140522020322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pingas", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_pingas", force: true do |t|
    t.integer  "user_id"
    t.integer  "pinga_id"
    t.string   "rsvp_status"
    t.string   "attend_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

end
