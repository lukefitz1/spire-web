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

ActiveRecord::Schema.define(version: 2020_04_18_230843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "additionalInfo"
    t.string "artist_image"
  end

  create_table "artworks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ojbId", null: false
    t.string "artType"
    t.string "title"
    t.string "date"
    t.string "medium"
    t.string "image"
    t.text "description"
    t.string "dimensions"
    t.string "frame_dimensions"
    t.string "condition"
    t.string "currentLocation"
    t.string "source"
    t.string "dateAcquired"
    t.string "amountPaid"
    t.string "currentValue"
    t.text "notes"
    t.string "notesImage"
    t.string "additionalInfoLabel"
    t.text "additionalInfoText"
    t.string "additionalInfoImage"
    t.string "additionalPdf"
    t.string "reviewedBy"
    t.string "reviewedDate"
    t.text "provenance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "artist_id"
    t.uuid "customer_id"
    t.uuid "collection_id"
    t.string "dateAcquiredLabel"
    t.string "notesImageTwo"
    t.string "additionalInfoImageTwo"
    t.uuid "general_information_id"
    t.boolean "show_general_info"
    t.string "custom_title"
    t.boolean "include_artist_and_general_info"
    t.index ["artist_id"], name: "index_artworks_on_artist_id"
    t.index ["collection_id"], name: "index_artworks_on_collection_id"
    t.index ["customer_id"], name: "index_artworks_on_customer_id"
    t.index ["general_information_id"], name: "index_artworks_on_general_information_id"
  end

  create_table "artworks_general_informations", id: false, force: :cascade do |t|
    t.uuid "general_information_id", null: false
    t.uuid "artwork_id", null: false
    t.index ["general_information_id", "artwork_id"], name: "index_art_general_infos_on_general_infos_id_and_art_id", unique: true
  end

  create_table "collections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "collectionName"
    t.uuid "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
    t.string "year"
    t.string "customer_proposals", default: [], array: true
    t.string "customer_invoices", default: [], array: true
    t.string "additional_photos", default: [], array: true
    t.json "files"
    t.string "bucket_name"
    t.index ["customer_id"], name: "index_collections_on_customer_id"
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email_address"
    t.string "phone_number"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "referred_by"
    t.text "project_notes"
    t.string "customer_photos", default: [], array: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "general_informations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "information_label"
    t.text "information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "customer_id"
    t.index ["customer_id"], name: "index_media_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.string "type"
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "visit_notes"
    t.date "visit_date_start"
    t.date "visit_date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "collection_id"
    t.index ["collection_id"], name: "index_visits_on_collection_id"
  end

  add_foreign_key "artworks", "artists"
  add_foreign_key "artworks", "collections"
  add_foreign_key "artworks", "customers"
  add_foreign_key "artworks", "general_informations"
  add_foreign_key "collections", "customers"
  add_foreign_key "media", "customers"
  add_foreign_key "visits", "collections"
end
