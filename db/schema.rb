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

ActiveRecord::Schema.define(version: 20140203222843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: true do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.string   "scope"
    t.datetime "expired_at"
    t.datetime "created_at"
  end

  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "bulletins", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "user_id"
    t.string   "slug"
    t.boolean  "is_dead",         default: false
    t.integer  "score",           default: 0
    t.integer  "high_score",      default: 0
    t.datetime "expiration_date"
    t.boolean  "expired",         default: false
    t.integer  "author_id"
    t.string   "author_type"
    t.integer  "views_count",     default: 0
  end

  add_index "bulletins", ["slug"], name: "index_bulletins_on_slug", using: :btree

  create_table "comments", force: true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "membership_applications", force: true do |t|
    t.integer  "user_id"
    t.integer  "membership_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_status_id", default: 1
    t.integer  "organization_id"
    t.string   "code"
  end

  create_table "membership_types", force: true do |t|
    t.string   "name"
    t.integer  "internal_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "membership_type_id", default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",           default: false
  end

  create_table "organization_types", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "int_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "youtube"
    t.string   "city"
    t.integer  "organization_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "university_id"
    t.boolean  "exposed",                  default: true
    t.string   "slug"
    t.boolean  "auto_approve_memberships", default: true
    t.text     "about"
    t.string   "instagram"
  end

  add_index "organizations", ["slug"], name: "index_organizations_on_slug", using: :btree

  create_table "universities", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.boolean  "approved",        default: false
    t.string   "image_url"
    t.text     "bio"
    t.string   "username"
    t.string   "password_digest"
  end

  create_table "views", force: true do |t|
    t.string   "ip"
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
