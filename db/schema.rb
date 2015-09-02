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

ActiveRecord::Schema.define(version: 20150617165817) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "contact_requests", force: :cascade do |t|
    t.string   "subject"
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "faq_articles", force: :cascade do |t|
    t.boolean  "published"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faq_requests", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "question_title"
    t.text     "question_description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "leaders", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name"
    t.string   "position"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "simple_wizard_tests", force: :cascade do |t|
    t.string   "tot__type_of_test"
    t.string   "top__type_of_product"
    t.text     "ps__platforms"
    t.string   "ps__hours"
    t.string   "pi__project_name"
    t.string   "pi__project_version"
    t.text     "pi__project_languages"
    t.text     "pi__report_languages"
    t.string   "tp__type_of_testing"
    t.text     "tp__exploratory_instructions"
    t.string   "tp__test_case_attachment_file_name"
    t.string   "tp__test_case_attachment_content_type"
    t.integer  "tp__test_case_attachment_file_size"
    t.datetime "tp__test_case_attachment_updated_at"
    t.string   "pa__access_instructions_url"
    t.string   "pa__access_instructions_attachment_file_name"
    t.string   "pa__access_instructions_attachment_content_type"
    t.integer  "pa__access_instructions_attachment_file_size"
    t.datetime "pa__access_instructions_attachment_updated_at"
    t.string   "pa__access_user_name"
    t.string   "pa__access_password"
    t.boolean  "pa__need_authorization"
    t.text     "pa__comment"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "state"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",                             null: false
    t.string   "uid",                     default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "city"
    t.integer  "zip_code"
    t.string   "company_url"
    t.string   "username"
    t.string   "image"
    t.string   "email"
    t.string   "billing_cardholder_name"
    t.string   "billing_address"
    t.string   "billing_card_number"
    t.string   "billing_cvv_number"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true

  create_table "wizard_platforms", force: :cascade do |t|
    t.string   "name"
    t.integer  "testers_count"
    t.string   "ancestry"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "wizard_tests", force: :cascade do |t|
    t.string   "state"
    t.float    "percent_completed"
    t.string   "steps_json"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
