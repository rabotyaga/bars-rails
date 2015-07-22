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

ActiveRecord::Schema.define(version: 20131221050501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.integer  "nr"
    t.string   "ar_inf"
    t.string   "form"
    t.string   "opt"
    t.string   "mn1"
    t.string   "ar1"
    t.string   "mn2"
    t.string   "ar2"
    t.string   "mn3"
    t.string   "ar3"
    t.text     "translation"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "first_letter_id"
    t.string   "ar_inf_wo_vowels"
    t.string   "source"
    t.boolean  "is_original"
    t.integer  "page"
    t.boolean  "is_root"
    t.integer  "root_id"
  end

  add_index "articles", ["first_letter_id"], name: "index_articles_on_first_letter_id", using: :btree
  add_index "articles", ["root_id"], name: "index_articles_on_root_id", using: :btree

  create_table "first_letters", force: true do |t|
    t.string   "letter"
    t.string   "notes"
    t.integer  "first_article_id"
    t.integer  "last_article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "action_id"
  end

  add_index "logs", ["action_id"], name: "index_logs_on_action_id", using: :btree
  add_index "logs", ["article_id"], name: "index_logs_on_article_id", using: :btree
  add_index "logs", ["user_id"], name: "index_logs_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "active",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.boolean  "can_edit"
    t.boolean  "can_add"
    t.boolean  "can_delete"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
