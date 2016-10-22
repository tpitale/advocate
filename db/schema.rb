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

ActiveRecord::Schema.define(version: 20161022134459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_locations", force: :cascade do |t|
    t.integer  "client_id"
    t.text     "address"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "client_locations", ["client_id"], name: "index_client_locations_on_client_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.text     "phone",                   null: false
    t.text     "first_name"
    t.text     "last_name"
    t.text     "last_address"
    t.text     "gender"
    t.text     "ssn"
    t.text     "ethnicity"
    t.text     "education"
    t.boolean  "employed"
    t.boolean  "veteran"
    t.boolean  "domestic_assault_victim"
    t.boolean  "mental_health"
    t.integer  "kid_count"
    t.date     "birthdate"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "clients", ["phone"], name: "index_clients_on_phone", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "interaction_id", null: false
    t.integer  "user_id"
    t.text     "source_type"
    t.text     "message_id"
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "events", ["interaction_id"], name: "index_events_on_interaction_id", using: :btree
  add_index "events", ["message_id"], name: "index_events_on_message_id", unique: true, using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "interactions", force: :cascade do |t|
    t.integer  "client_id",   null: false
    t.integer  "user_id"
    t.text     "status"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "interactions", ["client_id"], name: "index_interactions_on_client_id", using: :btree
  add_index "interactions", ["user_id"], name: "index_interactions_on_user_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.text     "name",       null: false
    t.text     "address"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "phone"
    t.text     "website"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.integer  "interaction_id", null: false
    t.integer  "service_id",     null: false
    t.text     "code",           null: false
    t.text     "status"
    t.text     "note"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "referrals", ["code"], name: "index_referrals_on_code", unique: true, using: :btree
  add_index "referrals", ["interaction_id"], name: "index_referrals_on_interaction_id", using: :btree
  add_index "referrals", ["service_id"], name: "index_referrals_on_service_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "provider_id"
    t.text     "role_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "roles", ["provider_id"], name: "index_roles_on_provider_id", using: :btree
  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "provider_id",                 null: false
    t.text     "category"
    t.text     "name",                        null: false
    t.boolean  "male",        default: false, null: false
    t.boolean  "female",      default: false, null: false
    t.boolean  "family",      default: false, null: false
    t.boolean  "sober",       default: false, null: false
    t.boolean  "ssn",         default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
