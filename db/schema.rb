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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110227065035) do

  create_table "coordinators", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "event_id", :null => false
  end

  add_index "coordinators", ["event_id"], :name => "fk_coordinators_event_id"
  add_index "coordinators", ["user_id"], :name => "fk_coordinators_user_id"

  create_table "events", :force => true do |t|
    t.string   "name",                                :null => false
    t.datetime "start_date",                          :null => false
    t.datetime "end_date",                            :null => false
    t.text     "summary"
    t.text     "additional"
    t.boolean  "show_organization", :default => true
    t.boolean  "show_coordinators", :default => true
    t.integer  "organization_id",                     :null => false
    t.integer  "location_id",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["location_id"], :name => "fk_events_location_id"
  add_index "events", ["organization_id"], :name => "fk_events_organization_id"

  create_table "locations", :force => true do |t|
    t.string   "name",                                       :null => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code",                                :null => false
    t.string   "phone_number"
    t.decimal  "latitude",     :precision => 8, :scale => 4
    t.decimal  "longitude",    :precision => 8, :scale => 4
    t.integer  "user_id",                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["user_id"], :name => "fk_locations_user_id"

  create_table "organizations", :force => true do |t|
    t.string   "name",        :null => false
    t.date     "founded"
    t.text     "summary"
    t.integer  "user_id",     :null => false
    t.integer  "location_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",   :null => false
  end

  add_index "organizations", ["location_id"], :name => "fk_organizations_location_id"
  add_index "organizations", ["user_id"], :name => "fk_organizations_user_id"

  create_table "shifts", :force => true do |t|
    t.string   "title",                          :null => false
    t.text     "description"
    t.time     "start"
    t.time     "end"
    t.integer  "event_id",                       :null => false
    t.integer  "volunteer_count", :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shifts", ["event_id"], :name => "fk_shifts_event_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                                 :null => false
    t.string   "encrypted_password",                                    :null => false
    t.string   "first_name",                                            :null => false
    t.string   "last_name",                                             :null => false
    t.datetime "last_login",         :default => '2011-02-24 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",                                                  :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
