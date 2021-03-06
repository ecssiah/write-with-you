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

ActiveRecord::Schema.define(version: 2018_05_26_221533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.integer "vote", default: 0
    t.index ["story_id"], name: "index_contributions_on_story_id"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "snippets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "story_id"
    t.string "content"
    t.boolean "paragraph_begin"
    t.boolean "paragraph_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["story_id"], name: "index_snippets_on_story_id"
    t.index ["user_id"], name: "index_snippets_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.string "color"
    t.integer "snippet_length", default: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subtitle"
    t.integer "creator_id"
    t.boolean "dark_theme"
    t.float "rank", default: 0.0
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  add_foreign_key "contributions", "stories"
  add_foreign_key "contributions", "users"
  add_foreign_key "snippets", "stories"
  add_foreign_key "snippets", "users"
end
