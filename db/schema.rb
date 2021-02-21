# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_19_004919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.date "availability_date"
    t.boolean "available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listing_id"], name: "index_availabilities_on_listing_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "host_name"
    t.integer "airbnb_id"
    t.boolean "active"
    t.datetime "last_scraped"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "host_id", null: false
    t.integer "airbnb_id"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.boolean "active"
    t.datetime "last_scraped"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id"], name: "index_listings_on_host_id"
  end

  add_foreign_key "availabilities", "listings"
  add_foreign_key "listings", "hosts"
end
