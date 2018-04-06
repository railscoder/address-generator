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

ActiveRecord::Schema.define(version: 20180406104623) do

  create_table "bitcoin_addresses", force: :cascade do |t|
    t.string   "private_hex", null: false
    t.string   "public_hex",  null: false
    t.string   "address",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["address"], name: "index_bitcoin_addresses_on_address"
  end

  create_table "etherum_addresses", force: :cascade do |t|
    t.string   "private_hex", null: false
    t.string   "public_hex",  null: false
    t.string   "address",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["address"], name: "index_etherum_addresses_on_address"
  end

  create_table "litecoin_addresses", force: :cascade do |t|
    t.string   "private_hex", null: false
    t.string   "public_hex",  null: false
    t.string   "address",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["address"], name: "index_litecoin_addresses_on_address"
  end

end