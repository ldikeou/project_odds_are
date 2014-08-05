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


ActiveRecord::Schema.define(version: 20140805145134) do

  create_table "bids", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "completion_status",         default: "ready_for_range"
    t.string   "description"
    t.integer  "range"
    t.integer  "recip_guess"
    t.integer  "challenger_guess"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bid_complete_file_name"
    t.string   "bid_complete_content_type"
    t.integer  "bid_complete_file_size"
    t.datetime "bid_complete_updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "requester_id"
    t.integer  "accepter_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer "notifiable_id"
    t.string  "notifiable_type"
    t.string  "type"
    t.string  "status"
    t.string  "message"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "l_status"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
