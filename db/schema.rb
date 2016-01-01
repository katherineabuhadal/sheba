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

ActiveRecord::Schema.define(version: 20151229184525) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
    t.text     "content",    limit: 65535
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "name",               limit: 255, null: false
    t.integer  "post_id",            limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "content",       limit: 65535
    t.datetime "published_at"
    t.boolean  "published"
    t.string   "external_link", limit: 255
    t.string   "style",         limit: 255
    t.string   "permalink",     limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "ingredients",   limit: 65535
  end

  create_table "video_links", force: :cascade do |t|
    t.integer  "post_id",      limit: 4,     null: false
    t.text     "english_link", limit: 65535
    t.text     "arabic_link",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
