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

ActiveRecord::Schema[7.0].define(version: 2022_11_15_062826) do
  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "state"
    t.integer "pincode"
    t.string "addressable_type", null: false
    t.integer "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_reservations", force: :cascade do |t|
    t.integer "food_id", null: false
    t.integer "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_food_reservations_on_food_id"
    t.index ["reservation_id"], name: "index_food_reservations_on_reservation_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.integer "available_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_reservations", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_reservations_on_game_id"
    t.index ["reservation_id"], name: "index_game_reservations_on_reservation_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.integer "available_set"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "table_number"
    t.integer "foods_count"
    t.integer "games_count"
    t.integer "tables_count"
    t.integer "people_count"
    t.integer "restaurant_id", null: false
    t.integer "customer_id", null: false
    t.integer "booking_amount"
    t.integer "billing_amount"
    t.string "booking_amount_status"
    t.string "billing_amount_status"
    t.string "status"
    t.time "from"
    t.time "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_reservations_on_customer_id"
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "food_reservations", "foods"
  add_foreign_key "food_reservations", "reservations"
  add_foreign_key "game_reservations", "games"
  add_foreign_key "game_reservations", "reservations"
  add_foreign_key "reservations", "customers"
  add_foreign_key "reservations", "restaurants"
end
