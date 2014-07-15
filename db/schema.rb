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

ActiveRecord::Schema.define(version: 20140715033523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cases", force: true do |t|
    t.string   "case_number"
    t.integer  "patient_id"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "subject"
    t.integer  "originator_id"
  end

  create_table "drugs", force: true do |t|
    t.string   "name"
    t.string   "dispense_amount"
    t.string   "dispense_frequency"
    t.string   "uuid"
    t.text     "adult_dosing"
    t.text     "peds_dosing"
    t.text     "contraindications"
    t.text     "dosage_forms"
    t.text     "pharmacy_instructions"
    t.text     "patient_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "uploaded_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imageable_uuid"
  end

  create_table "laboratory_orders", force: true do |t|
    t.integer  "patient_id"
    t.integer  "practitioner_id"
    t.integer  "laboratory_id"
    t.text     "requisition"
    t.string   "vita_number"
    t.datetime "due_date"
    t.integer  "shipping_method_id"
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "body"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "patient_id"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  create_table "organizations", force: true do |t|
    t.string "organization_type"
    t.string "name"
  end

  create_table "patients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "work_phone"
    t.string   "email"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "social_security_number"
  end

  create_table "practitioners", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "practice_name"
    t.string   "email"
    t.string   "specialty"
    t.string   "phone"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prescription_orders", force: true do |t|
    t.integer  "patient_id"
    t.integer  "practitioner_id"
    t.integer  "drug_id"
    t.string   "dispense"
    t.text     "instructions"
    t.text     "patient_instructions"
    t.date     "expiration_date"
    t.integer  "refills"
    t.integer  "pharmacy_id"
    t.string   "rx_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tooth_charts", force: true do |t|
    t.string   "chart_file_name"
    t.string   "chart_content_type"
    t.integer  "chart_file_size"
    t.datetime "chart_updated_at"
    t.integer  "case_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
