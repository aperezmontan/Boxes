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

ActiveRecord::Schema.define(version: 20160201004639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.string   "home_team_coord"
    t.string   "away_team_coord"
    t.integer  "home_team_num"
    t.integer  "away_team_num"
    t.boolean  "is_winner"
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "boxes", ["away_team_num"], name: "index_boxes_on_away_score_num", using: :btree
  add_index "boxes", ["game_id"], name: "index_boxes_on_game_id", using: :btree
  add_index "boxes", ["home_team_num"], name: "index_boxes_on_home_score_num", using: :btree
  add_index "boxes", ["user_id"], name: "index_boxes_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "home_team"
    t.string   "away_team"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "name"
    t.integer  "price"
    t.integer  "status",                    default: 0
    t.string   "description"
    t.integer  "first_quarter_home_score"
    t.integer  "second_quarter_home_score"
    t.integer  "third_quarter_home_score"
    t.integer  "fourth_quarter_home_score"
    t.integer  "first_quarter_away_score"
    t.integer  "second_quarter_away_score"
    t.integer  "third_quarter_away_score"
    t.integer  "fourth_quarter_away_score"
    t.string   "first_quarter_winner"
    t.string   "second_quarter_winner"
    t.string   "third_quarter_winner"
    t.string   "fourth_quarter_winner"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "home_score"
    t.integer  "away_score"
    t.boolean  "is_final"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quarter"
    t.string   "game_info"
    t.integer  "status",     default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "email",                               null: false
    t.string   "password_digest",                     null: false
    t.string   "role",            default: "regular", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
