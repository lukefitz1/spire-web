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

ActiveRecord::Schema.define(version: 20190208020740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "additionalInfo"
  end

  create_table "artworks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ojbId"
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
    t.index ["artist_id"], name: "index_artworks_on_artist_id"
    t.index ["collection_id"], name: "index_artworks_on_collection_id"
    t.index ["customer_id"], name: "index_artworks_on_customer_id"
  end

  create_table "collections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "collectionName"
    t.uuid "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
    t.string "year"
    t.index ["customer_id"], name: "index_collections_on_customer_id"
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "artworks", "artists"
  add_foreign_key "artworks", "collections"
  add_foreign_key "artworks", "customers"
  add_foreign_key "collections", "customers"
end
