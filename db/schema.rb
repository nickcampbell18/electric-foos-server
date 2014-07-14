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

ActiveRecord::Schema.define(version: 20140713104627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "games", id: :uuid, default: "uuid_generate_v1()", force: true do |t|
    t.integer  "silver_sig_one_id"
    t.integer  "silver_sig_two_id"
    t.integer  "black_sig_one_id"
    t.integer  "black_sig_two_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: true do |t|
    t.uuid     "game_id"
    t.string   "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", id: :uuid, default: "uuid_generate_v1()", force: true do |t|
    t.string "name", limit: 64
  end

  create_table "signatures", force: true do |t|
    t.string "sig",       limit: 100
    t.uuid   "player_id"
  end

  add_index "signatures", ["sig"], name: "index_signatures_on_sig", unique: true, using: :btree

end
