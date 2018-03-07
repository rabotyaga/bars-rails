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

ActiveRecord::Schema.define(version: 20151127124619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alphabets", id: :serial, force: :cascade do |t|
    t.integer "nr"
    t.string "letter"
    t.integer "nv"
    t.string "name"
    t.string "transcription"
    t.string "ar_name"
    t.string "ar_name_transcription"
    t.boolean "has_all_writings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", id: :serial, force: :cascade do |t|
    t.integer "nr"
    t.string "ar_inf", limit: 255
    t.string "form", limit: 255
    t.string "opt", limit: 255
    t.string "mn1", limit: 255
    t.string "ar1", limit: 255
    t.string "mn2", limit: 255
    t.string "ar2", limit: 255
    t.string "mn3", limit: 255
    t.string "ar3", limit: 255
    t.text "translation"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "first_letter_id"
    t.string "ar_inf_wo_vowels", limit: 255
    t.string "source", limit: 255
    t.boolean "is_original"
    t.integer "page"
    t.boolean "is_root"
    t.integer "root_id"
    t.string "transcription", limit: 255
    t.string "vocalization", limit: 255
    t.integer "homonym_nr"
    t.string "ar_inf_wo_vowels_n_hamza", limit: 255
    t.string "ar123_wo_vowels_n_hamza"
    t.index ["first_letter_id"], name: "index_articles_on_first_letter_id"
    t.index ["root_id"], name: "index_articles_on_root_id"
  end

  create_table "first_letters", id: :serial, force: :cascade do |t|
    t.string "letter", limit: 255
    t.string "notes", limit: 255
    t.integer "first_article_id"
    t.integer "last_article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "article_id"
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "action_id"
    t.index ["action_id"], name: "index_logs_on_action_id"
    t.index ["article_id"], name: "index_logs_on_article_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.boolean "active", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_admin"
    t.boolean "can_edit"
    t.boolean "can_add"
    t.boolean "can_delete"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
