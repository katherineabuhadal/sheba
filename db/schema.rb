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

ActiveRecord::Schema.define(version: 20160102232856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipe_id",  null: false
    t.text     "content",    null: false
    t.integer  "parent_id"
    t.string   "title"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.integer  "recipe_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "content"
    t.text     "ingredients"
    t.boolean  "published",   default: false, null: false
    t.string   "permalink"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "video_links", force: :cascade do |t|
    t.integer  "recipe_id",    null: false
    t.text     "english_link"
    t.text     "arabic_link"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
