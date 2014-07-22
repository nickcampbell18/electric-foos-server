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

ActiveRecord::Schema.define(version: 20140722170144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "games", id: :uuid, default: "uuid_generate_v1()", force: true do |t|
    t.json     "unclaimed_signatures"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ended",                default: false
  end

  create_table "goals", force: true do |t|
    t.uuid     "game_id"
    t.string   "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", id: :uuid, default: "uuid_generate_v1()", force: true do |t|
    t.string "name",       limit: 64
    t.string "signatures",             default: [], array: true
    t.string "mugshot",    limit: 120
    t.string "permalink",  limit: 40
  end

  add_index "players", ["signatures"], name: "index_players_on_signatures", using: :gin

  create_table "teams", force: true do |t|
    t.uuid    "game_id"
    t.uuid    "player_one_id"
    t.uuid    "player_two_id"
    t.integer "team_colour",   default: 0
  end

  add_index "teams", ["game_id"], name: "index_teams_on_game_id", using: :btree
  add_index "teams", ["player_one_id"], name: "index_teams_on_player_one_id", using: :btree
  add_index "teams", ["player_two_id"], name: "index_teams_on_player_two_id", using: :btree

end
