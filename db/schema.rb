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

ActiveRecord::Schema.define(version: 20160627230645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "category_charities", force: :cascade do |t|
    t.string "name"
  end

  create_table "category_events", force: :cascade do |t|
    t.string "name"
  end

  create_table "charities", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.integer "category_charity_id"
  end

  add_index "charities", ["category_charity_id"], name: "index_charities_on_category_charity_id", using: :btree

  create_table "donation_items", force: :cascade do |t|
    t.integer  "ticket_quantity"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "donation_id"
    t.integer  "event_item_id"
  end

  add_index "donation_items", ["donation_id"], name: "index_donation_items_on_donation_id", using: :btree
  add_index "donation_items", ["event_item_id"], name: "index_donation_items_on_event_item_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "donations", ["user_id"], name: "index_donations_on_user_id", using: :btree

  create_table "event_items", force: :cascade do |t|
    t.integer  "ticket_quantity"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "event_id"
    t.integer  "recipient_id"
  end

  add_index "event_items", ["event_id"], name: "index_event_items_on_event_id", using: :btree
  add_index "event_items", ["recipient_id"], name: "index_event_items_on_recipient_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "ticket_price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "date"
    t.integer  "category_event_id"
  end

  add_index "events", ["category_event_id"], name: "index_events_on_category_event_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "description"
    t.string   "recipient_photo_file_name"
    t.string   "recipient_photo_content_type"
    t.integer  "recipient_photo_file_size"
    t.datetime "recipient_photo_updated_at"
    t.integer  "charity_id"
  end

  add_index "recipients", ["charity_id"], name: "index_recipients_on_charity_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.string   "email"
  end

  add_foreign_key "charities", "category_charities"
  add_foreign_key "donation_items", "donations"
  add_foreign_key "donation_items", "event_items"
  add_foreign_key "donations", "users"
  add_foreign_key "event_items", "events"
  add_foreign_key "event_items", "recipients"
  add_foreign_key "events", "category_events"
  add_foreign_key "recipients", "charities"
end
