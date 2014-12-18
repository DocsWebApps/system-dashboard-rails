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

ActiveRecord::Schema.define(version: 20141218211736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "contact",    limit: 255
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incident_histories", force: true do |t|
    t.string   "fault_ref",   limit: 255
    t.text     "description"
    t.date     "date"
    t.string   "status",      limit: 255
    t.integer  "system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "severity",    limit: 255
    t.time     "time"
    t.datetime "closed_at"
  end

  add_index "incident_histories", ["system_id"], name: "index_incident_histories_on_system_id", using: :btree

  create_table "incidents", force: true do |t|
    t.string   "fault_ref",   limit: 255
    t.text     "description"
    t.date     "date"
    t.string   "status",      limit: 255
    t.integer  "system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "severity",    limit: 255
    t.time     "time"
    t.datetime "closed_at"
  end

  add_index "incidents", ["system_id"], name: "index_incidents_on_system_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", force: true do |t|
    t.string   "name",               limit: 255
    t.string   "status",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_id"
    t.date     "last_incident_date"
  end

  create_table "users", force: true do |t|
    t.string   "email",           limit: 255
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token",      limit: 255
  end

  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
