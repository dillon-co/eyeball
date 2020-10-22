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

ActiveRecord::Schema.define(version: 2020_10_18_001231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payment_categories", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "payment_charges", id: :serial, force: :cascade do |t|
    t.integer "payment_category_id"
    t.integer "payment_group_id"
    t.text "raw"
    t.string "amount_in_pennies"
    t.datetime "occurred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "plaid_items_id"
    t.index ["payment_category_id"], name: "index_payment_charges_on_payment_category_id"
    t.index ["payment_group_id"], name: "index_payment_charges_on_payment_group_id"
    t.index ["plaid_items_id"], name: "index_payment_charges_on_plaid_items_id"
  end

  create_table "payment_groups", id: :serial, force: :cascade do |t|
  end

  create_table "payment_schedules", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "amount_in_pennies"
    t.datetime "recurrence_start"
    t.integer "recurrence_date"
    t.integer "recurrence_wday"
    t.integer "recurrence_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plaid_items", force: :cascade do |t|
    t.string "bank_name"
    t.text "plaid_item_id"
    t.text "plaid_item_access_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "payment_charges", "plaid_items", column: "plaid_items_id"
end
