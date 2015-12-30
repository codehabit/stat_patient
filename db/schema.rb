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

ActiveRecord::Schema.define(version: 20151230140511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type", limit: 255
    t.string   "type",             limit: 255
    t.string   "title",            limit: 255
    t.string   "street1",          limit: 255
    t.string   "street2",          limit: 255
    t.string   "city",             limit: 255
    t.string   "state",            limit: 255
    t.string   "postal_code",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "annotations", force: :cascade do |t|
    t.integer "attachment_id"
    t.string  "text",          limit: 255
    t.integer "height"
    t.integer "width"
    t.integer "top"
    t.integer "left"
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type",    limit: 255
    t.integer  "uploaded_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachable_uuid",    limit: 255
    t.string   "type",               limit: 255
  end

  create_table "case_watchers", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "watcher_id"
    t.string   "watcher_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cases", force: :cascade do |t|
    t.string   "case_number",        limit: 255
    t.integer  "patient_id"
    t.integer  "recipient_id"
    t.string   "recipient_type",     limit: 255
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "subject",            limit: 255
    t.integer  "originator_id"
    t.boolean  "read"
    t.boolean  "starred"
    t.boolean  "urgent"
    t.datetime "last_activity_date"
    t.boolean  "new_reply"
    t.boolean  "archived"
    t.string   "flavor",             limit: 255
    t.integer  "passthrough_id"
  end

  create_table "ceramics", force: :cascade do |t|
    t.string   "material",           limit: 255
    t.string   "shade",              limit: 255
    t.string   "occlusion",          limit: 255
    t.string   "contact",            limit: 255
    t.integer  "laboratory_id"
    t.integer  "laboratory_oder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circles", force: :cascade do |t|
    t.integer "hub_id"
    t.integer "spoke_id"
    t.string  "timestamps", limit: 255
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "contactable_type", limit: 255
    t.integer  "contactable_id"
    t.string   "contact_type",     limit: 255
    t.string   "info",             limit: 255
    t.string   "title",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drug_diagnosis_assignments", force: :cascade do |t|
    t.integer  "diagnosis_id"
    t.string   "drug_uuid",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugs", force: :cascade do |t|
    t.string   "name",                            limit: 255
    t.string   "dispense_amount",                 limit: 255
    t.string   "uuid",                            limit: 255
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
    t.string   "regimen",                         limit: 255
    t.integer  "dea_schedule"
    t.string   "category",                        limit: 255
  end

  create_table "lab_items", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "price",               limit: 255
    t.string   "description",         limit: 255
    t.string   "item_type",           limit: 255
    t.integer  "laboratory_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "occlusion",           limit: 255
  end

  create_table "laboratory_orders", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "originator_id"
    t.integer  "recipient_id"
    t.text     "requisition"
    t.string   "vita_color_id",        limit: 255
    t.datetime "due_date"
    t.string   "shipping_method_name", limit: 255
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient_type",       limit: 255
    t.string   "uuid",                 limit: 255
    t.text     "description"
    t.string   "removable",            limit: 255
    t.boolean  "submitted"
    t.boolean  "closed"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "body",           limit: 255
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "patient_id"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",           limit: 255
    t.string   "type",           limit: 255
    t.string   "recipient_type", limit: 255
    t.string   "sender_type",    limit: 255
  end

  create_table "organization_memberships", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "practitioner_id"
    t.string   "role",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "type",                         limit: 255
    t.string "name",                         limit: 255
    t.string "national_provider_identifier", limit: 255
    t.string "time_zone",                    limit: 255
  end

  create_table "patients", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "middle_initial",         limit: 255
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                  limit: 255
    t.string   "street",                 limit: 255
    t.string   "street2",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "zip_code",               limit: 255
    t.string   "home_phone",             limit: 255
    t.string   "mobile_phone",           limit: 255
    t.string   "work_phone",             limit: 255
    t.string   "email",                  limit: 255
    t.string   "gender",                 limit: 255
    t.string   "marital_status",         limit: 255
    t.string   "social_security_number", limit: 255
  end

  create_table "pfms", force: :cascade do |t|
    t.string   "material",           limit: 255
    t.string   "margin",             limit: 255
    t.string   "pontic",             limit: 255
    t.string   "occlusion",          limit: 255
    t.string   "contact",            limit: 255
    t.integer  "laboratory_id"
    t.integer  "laboratory_oder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practitioner_patients", force: :cascade do |t|
    t.integer "practitioner_id"
    t.integer "patient_id"
    t.string  "timestamps",      limit: 255
  end

  create_table "practitioners", force: :cascade do |t|
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "specialty",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",          limit: 255
    t.string   "salutation",     limit: 255
    t.string   "suffix",         limit: 255
    t.string   "dea_identifier", limit: 255
    t.string   "npi",            limit: 255
    t.string   "primary_phone",  limit: 255
    t.string   "email",          limit: 255
    t.integer  "hub_id"
  end

  create_table "prescription_orders", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "practitioner_id"
    t.string   "dispense_amount",          limit: 255
    t.text     "rx_instructions"
    t.text     "patient_instructions"
    t.date     "expiration_date"
    t.integer  "refills"
    t.integer  "pharmacy_id"
    t.string   "rx_id",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "practice_id"
    t.boolean  "dispense_only_as_written"
    t.boolean  "label"
    t.string   "flow_status",              limit: 255
    t.string   "drug_uuid",                limit: 255
  end

  create_table "read_receipts", force: :cascade do |t|
    t.integer  "practitioner_id"
    t.integer  "read_case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tooth_chart_markings", force: :cascade do |t|
    t.integer "tooth_chart_id"
    t.integer "tooth_id"
    t.integer "status_code"
    t.string  "notes",          limit: 255
  end

  add_index "tooth_chart_markings", ["tooth_chart_id"], name: "index_tooth_chart_markings_on_tooth_chart_id", using: :btree

  create_table "tooth_charts", force: :cascade do |t|
    t.string   "chart_file_name",    limit: 255
    t.string   "chart_content_type", limit: 255
    t.integer  "chart_file_size"
    t.datetime "chart_updated_at"
    t.integer  "case_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "visit_artifact_attachments", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "artifact_id"
    t.string   "artifact_type",      limit: 255
    t.integer  "created_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "practitioner_id"
    t.integer  "organization_id"
    t.datetime "visit_start_dttm"
    t.integer  "created_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
