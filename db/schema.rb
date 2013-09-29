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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130527170708) do

  create_table "drugs", :force => true do |t|
    t.string    "generic_name"
    t.string    "medical_name"
    t.string    "form"
    t.string    "conditions"
    t.integer   "thirty_day_price"
    t.integer   "thirty_day_quantity"
    t.integer   "ninety_day_price"
    t.integer   "ninety_day_quantity"
    t.timestamp "created_at",          :null => false
    t.timestamp "updated_at",          :null => false
  end

  create_table "drugs_stores", :id => false, :force => true do |t|
    t.integer "drug_id"
    t.integer "store_id"
  end

  add_index "drugs_stores", ["drug_id", "store_id"], :name => "index_drugs_stores_on_drug_id_and_store_id"

  create_table "stores", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

end
