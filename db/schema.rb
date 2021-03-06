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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 6) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.date     "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "group_members", :force => true do |t|
    t.integer  "group_id",   :default => 0, :null => false
    t.integer  "user_id",    :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "group_members", ["group_id"], :name => "index_group_members_on_group_id"
  add_index "group_members", ["user_id"], :name => "index_group_members_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "event_id"
    t.integer  "stars"
    t.integer  "stars_max"
    t.integer  "stars_extra"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "timeslots", :force => true do |t|
    t.time     "start"
    t.time     "finish"
    t.integer  "event_id",   :null => false
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "postal_code"
    t.string   "city"
    t.string   "phone_landline"
    t.string   "phone_mobile"
    t.date     "date_of_birth"
    t.integer  "gender"
    t.string   "email"
    t.string   "password_digest"
    t.string   "activation_token"
    t.boolean  "active",           :default => false, :null => false
    t.string   "remember_token"
    t.integer  "role",             :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
