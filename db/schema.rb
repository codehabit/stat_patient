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

ActiveRecord::Schema.define(version: 20150227170834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "type"
    t.string   "title"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "annotations", force: true do |t|
    t.integer "attachment_id"
    t.string  "text"
    t.integer "height"
    t.integer "width"
    t.integer "top"
    t.integer "left"
  end

  create_table "attachments", force: true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "uploaded_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachable_uuid"
    t.string   "type"
  end

  create_table "case_watchers", force: true do |t|
    t.integer  "case_id"
    t.integer  "watcher_id"
    t.string   "watcher_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.boolean  "read"
    t.boolean  "starred"
    t.boolean  "urgent"
    t.datetime "last_activity_date"
    t.boolean  "new_reply"
  end

  create_table "ceramics", force: true do |t|
    t.string   "material"
    t.string   "shade"
    t.string   "occlusion"
    t.string   "contact"
    t.integer  "laboratory_id"
    t.integer  "laboratory_oder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "contactable_type"
    t.integer  "contactable_id"
    t.string   "contact_type"
    t.string   "info"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drug_diagnosis_assignments", force: true do |t|
    t.integer  "diagnosis_id"
    t.string   "drug_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugs", force: true do |t|
    t.string   "name"
    t.string   "dispense_amount"
    t.string   "uuid"
    t.text     "strength"
    t.text     "peds_dosing"
    t.text     "contraindications"
    t.text     "dosage_form"
    t.text     "instructions_precautions"
    t.text     "sig"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "interactions"
    t.text     "pregnancy_lactating_precautions"
    t.string   "regimen"
    t.integer  "dea_schedule"
    t.string   "category"
  end

  create_table "lab_items", force: true do |t|
    t.string   "name"
    t.string   "price"
    t.string   "description"
    t.string   "item_type"
    t.integer  "laboratory_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "occlusion"
  end

  create_table "laboratory_orders", force: true do |t|
    t.integer  "patient_id"
    t.integer  "originator_id"
    t.integer  "recipient_id"
    t.text     "requisition"
    t.string   "vita_color_id"
    t.datetime "due_date"
    t.string   "shipping_method_name"
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient_type"
    t.string   "uuid"
    t.text     "description"
    t.string   "removable"
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
    t.string   "type"
    t.string   "recipient_type"
    t.string   "sender_type"
  end

  create_table "organization_memberships", force: true do |t|
    t.integer  "organization_id"
    t.integer  "practitioner_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string "type"
    t.string "name"
    t.string "national_provider_identifier"
    t.string "time_zone"
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

  create_table "pfms", force: true do |t|
    t.string   "material"
    t.string   "margin"
    t.string   "pontic"
    t.string   "occlusion"
    t.string   "contact"
    t.integer  "laboratory_id"
    t.integer  "laboratory_oder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practitioners", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "specialty"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "salutation"
    t.string   "suffix"
    t.string   "dea_identifier"
  end

  create_table "prescription_orders", force: true do |t|
    t.integer  "patient_id"
    t.integer  "practitioner_id"
    t.string   "dispense_amount"
    t.text     "rx_instructions"
    t.text     "patient_instructions"
    t.date     "expiration_date"
    t.integer  "refills"
    t.integer  "pharmacy_id"
    t.string   "rx_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "practice_id"
    t.boolean  "dispense_only_as_written"
    t.boolean  "label"
    t.string   "flow_status"
    t.string   "drug_uuid"
  end

  create_table "tooth_chart_markings", force: true do |t|
    t.integer "tooth_chart_id"
    t.integer "tooth_id"
    t.integer "status_code"
    t.string  "notes"
  end

  add_index "tooth_chart_markings", ["tooth_chart_id"], name: "index_tooth_chart_markings_on_tooth_chart_id", using: :btree

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

  create_table "visit_artifact_attachments", force: true do |t|
    t.integer  "visit_id"
    t.integer  "artifact_id"
    t.string   "artifact_type"
    t.integer  "created_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", force: true do |t|
    t.integer  "patient_id"
    t.integer  "practitioner_id"
    t.integer  "organization_id"
    t.datetime "visit_start_dttm"
    t.integer  "created_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
