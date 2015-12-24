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

ActiveRecord::Schema.define(version: 20151224121011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.integer  "home_team_num"
    t.integer  "away_team_num"
    t.boolean  "winner?"
    t.string   "win_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "home_team"
    t.string   "away_team"
    t.integer  "current_home_result"
    t.integer  "current_away_result"
    t.integer  "first_quarter_home_result"
    t.integer  "second_quarter_home_result"
    t.integer  "third_quarter_home_result"
    t.integer  "final_home_result"
    t.integer  "first_quarter_away_result"
    t.integer  "second_quarter_away_result"
    t.integer  "third_quarter_away_result"
    t.integer  "final_away_result"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
