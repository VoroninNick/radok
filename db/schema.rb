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

ActiveRecord::Schema.define(version: 20160411052806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "assetable_field_name"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.string   "data_alt"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "banners", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "title"
    t.string   "description"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "button_label"
    t.string   "button_url"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title_html_tag"
  end

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

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "sorting_position"
    t.string   "client_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "contact_feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "url_fragment"
  end

  create_table "faq_requests", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "form_configs", force: :cascade do |t|
    t.string   "type"
    t.text     "email_receivers"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "html_blocks", force: :cascade do |t|
    t.text    "content"
    t.integer "attachable_id"
    t.string  "attachable_type"
    t.string  "attachable_field_name"
    t.string  "key"
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

  create_table "pages", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.text     "content"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_requests", force: :cascade do |t|
    t.string   "full_name"
    t.string   "phone"
    t.string   "email"
    t.string   "comment"
    t.string   "payment_type"
    t.string   "billing_address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "country"
    t.string   "card_holder_name"
    t.string   "card_number"
    t.string   "exp_month"
    t.string   "exp_year"
    t.string   "cvv_number"
    t.integer  "test_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "schedule_call_requests", force: :cascade do |t|
    t.string   "phone"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "seo_tags", force: :cascade do |t|
    t.string   "page_type"
    t.integer  "page_id"
    t.string   "title"
    t.text     "keywords"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

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

  create_table "sitemap_elements", force: :cascade do |t|
    t.string   "page_type"
    t.integer  "page_id"
    t.boolean  "display_on_sitemap"
    t.string   "changefreq"
    t.float    "priority"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "full_name"
    t.boolean  "subscribed"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
    t.datetime "saved_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wizard_devices", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "model"
    t.string   "os"
    t.integer  "screen_pixel_width"
    t.integer  "screen_pixel_height"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "wizard_devices", ["manufacturer_id"], name: "index_wizard_devices_on_manufacturer_id", using: :btree

  create_table "wizard_manufacturers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wizard_platforms", force: :cascade do |t|
    t.string   "name"
    t.integer  "testers_count"
    t.string   "ancestry"
    t.integer  "position"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "wizard_platforms_product_types", id: false, force: :cascade do |t|
    t.integer "platform_id"
    t.integer "product_type_id"
  end

  add_index "wizard_platforms_product_types", ["platform_id", "product_type_id"], name: "index_unique_platforms_product_types", unique: true, using: :btree

  create_table "wizard_product_types", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "wizard_project_languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wizard_promo_codes", force: :cascade do |t|
    t.string   "password",            null: false
    t.float    "percentage_discount"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "wizard_promo_codes", ["password"], name: "index_wizard_promo_codes_on_password", unique: true, using: :btree

  create_table "wizard_report_languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wizard_settings", force: :cascade do |t|
    t.integer  "hour_price"
    t.boolean  "enable_credit_card_payment_method"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "enable_paypal_payment_method"
  end

  create_table "wizard_test_platforms", id: false, force: :cascade do |t|
    t.integer  "platform_id",   null: false
    t.integer  "test_id",       null: false
    t.integer  "testers_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "comment"
  end

  add_index "wizard_test_platforms", ["test_id", "platform_id"], name: "index_wizard_test_platform_unique_bindings", unique: true, using: :btree

  create_table "wizard_test_project_languages", force: :cascade do |t|
    t.integer "test_id"
    t.integer "project_language_id"
  end

  add_index "wizard_test_project_languages", ["project_language_id"], name: "index_wizard_test_project_languages_on_project_language_id", using: :btree
  add_index "wizard_test_project_languages", ["test_id"], name: "index_wizard_test_project_languages_on_test_id", using: :btree

  create_table "wizard_test_report_languages", force: :cascade do |t|
    t.integer "test_id"
    t.integer "report_language_id"
  end

  add_index "wizard_test_report_languages", ["report_language_id"], name: "index_wizard_test_report_languages_on_report_language_id", using: :btree
  add_index "wizard_test_report_languages", ["test_id"], name: "index_wizard_test_report_languages_on_test_id", using: :btree

  create_table "wizard_test_types", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "wizard_tests", force: :cascade do |t|
    t.string   "state"
    t.float    "percent_completed"
    t.integer  "hours_per_tester"
    t.string   "project_name"
    t.string   "project_version"
    t.string   "methodology_type"
    t.text     "exploratory_description"
    t.string   "project_url"
    t.boolean  "authentication_required"
    t.string   "auth_login"
    t.string   "auth_password"
    t.text     "comment"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "product_type_id"
    t.integer  "test_type_id"
    t.integer  "user_id"
    t.integer  "active_step_number"
    t.integer  "proceeded_steps_count"
    t.datetime "completed_at"
    t.datetime "tested_at"
    t.datetime "expected_tested_at"
    t.boolean  "successful"
    t.integer  "current_step_id"
    t.integer  "total_price"
    t.text     "main_components"
    t.text     "project_info_comment"
    t.text     "project_access_comment"
    t.text     "platforms_comment"
    t.string   "contact_person_name"
    t.string   "contact_person_phone"
    t.string   "contact_person_email"
    t.text     "admin_comment"
    t.integer  "promo_code_id"
  end

  create_table "wizard_texts", force: :cascade do |t|
    t.text     "json_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
