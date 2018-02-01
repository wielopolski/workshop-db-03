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

ActiveRecord::Schema.define(version: 20180205143040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.date "played_at", null: false
    t.integer "day", null: false
    t.integer "month", null: false
    t.integer "quarter", null: false
    t.integer "year", null: false
    t.integer "wday", null: false
    t.index ["game_id"], name: "index_matches_on_game_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.integer "points", default: 0, null: false
    t.index ["match_id", "player_id"], name: "index_scores_on_match_id_and_player_id", unique: true
    t.index ["match_id"], name: "index_scores_on_match_id"
    t.index ["player_id"], name: "index_scores_on_player_id"
  end

  add_foreign_key "matches", "games", on_update: :cascade, on_delete: :cascade
  add_foreign_key "scores", "matches", on_update: :cascade, on_delete: :cascade
  add_foreign_key "scores", "players", on_update: :cascade, on_delete: :cascade
end
