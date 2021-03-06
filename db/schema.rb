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

ActiveRecord::Schema.define(version: 2019_04_17_050935) do

  create_table "kickings", force: :cascade do |t|
    t.string "fld_goals_made"
    t.string "fld_goals_att"
    t.string "extra_pt_made"
    t.string "extra_pt_att"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entry_id"
    t.index ["entry_id"], name: "index_kickings_on_entry_id", unique: true
    t.index ["player_id"], name: "index_kickings_on_player_id"
  end

  create_table "passings", force: :cascade do |t|
    t.string "yds"
    t.string "att"
    t.string "tds"
    t.string "cmp"
    t.string "int"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entry_id"
    t.index ["entry_id"], name: "index_passings_on_entry_id", unique: true
    t.index ["player_id"], name: "index_passings_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "player_id"
    t.string "position"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_players_on_player_id", unique: true
  end

  create_table "receivings", force: :cascade do |t|
    t.string "yds"
    t.string "tds"
    t.string "rec"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entry_id"
    t.index ["entry_id"], name: "index_receivings_on_entry_id", unique: true
    t.index ["player_id"], name: "index_receivings_on_player_id"
  end

  create_table "rushings", force: :cascade do |t|
    t.string "yds"
    t.string "att"
    t.string "tds"
    t.string "fum"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entry_id"
    t.index ["entry_id"], name: "index_rushings_on_entry_id", unique: true
    t.index ["player_id"], name: "index_rushings_on_player_id"
  end

end
