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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130521122141) do

  create_table "bulletins", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "bulletin_type", :default => 1
    t.string   "url"
    t.integer  "user_id"
    t.boolean  "protected",     :default => false
    t.string   "slug"
    t.boolean  "is_dead",       :default => false
  end

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  create_table "emails", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "message_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "membership_type_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "approved",           :default => false
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "test",       :default => true
    t.string   "from_name"
    t.string   "from_email"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "recipient_email"
    t.integer  "bulletin_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "organization_types", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "int_ref"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "youtube"
    t.string   "city"
    t.integer  "organization_type_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "email"
    t.integer  "university_id"
    t.boolean  "exposed",                  :default => true
    t.string   "slug"
    t.boolean  "auto_approve_memberships", :default => true
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "product_id"
    t.integer  "beneficiary_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "email"
    t.string   "download_code"
    t.boolean  "expired",        :default => false
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "full_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "submitted_by_ip"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "votable_type"
  end

end
