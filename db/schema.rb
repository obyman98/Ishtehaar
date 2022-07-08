# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_07_093301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ads", force: :cascade do |t|
    t.string "title"
    t.text "status", default: "pending"
    t.string "comment"
    t.integer "count"
    t.date "schedule_date_start"
    t.date "schedule_date_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ad_data"
    t.bigint "user_id", null: false
    t.text "url"
    t.text "eld_id"
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "state"
    t.string "city"
    t.string "ntn"
    t.integer "poc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "elds", force: :cascade do |t|
    t.text "identifier"
    t.text "mac_address"
    t.text "wifi_ssid"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_elds_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.integer "ad_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "eld_id", null: false
    t.bigint "ad_id", null: false
    t.index ["ad_id"], name: "index_events_on_ad_id"
    t.index ["eld_id"], name: "index_events_on_eld_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fullname"
    t.boolean "active"
    t.date "dob"
    t.string "nic"
    t.string "email"
    t.string "role"
    t.string "phone"
    t.string "vehicle_id"
    t.boolean "onboarding_complete"
    t.string "driver_license_number"
    t.string "driver_license_state"
    t.string "driver_eld_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vin"
    t.string "license_number_plate"
    t.string "make"
    t.string "model"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.text "comment"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ads", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "elds", "users"
  add_foreign_key "events", "ads"
  add_foreign_key "events", "elds"
  add_foreign_key "vehicles", "users"
end
