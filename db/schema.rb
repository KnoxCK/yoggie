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

ActiveRecord::Schema.define(version: 20180716180017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address_line_one"
    t.integer  "customer_id"
    t.string   "address_line_two"
    t.string   "address_line_three"
    t.string   "postcode"
    t.text     "delivery_instructions"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id", using: :btree
  end

  create_table "basket_smoothies", force: :cascade do |t|
    t.integer  "basket_id"
    t.integer  "smoothie_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["basket_id"], name: "index_basket_smoothies_on_basket_id", using: :btree
    t.index ["smoothie_id"], name: "index_basket_smoothies_on_smoothie_id", using: :btree
  end

  create_table "baskets", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["customer_id"], name: "index_baskets_on_customer_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "age"
    t.string   "gender"
    t.integer  "weight"
    t.integer  "height"
    t.string   "activity_level"
    t.string   "goal"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "bmr"
    t.integer  "tdee"
    t.integer  "daily_calorie_goal"
    t.integer  "calories_per_shake"
    t.integer  "protein"
    t.integer  "fat"
    t.integer  "carbs"
    t.integer  "meals_per_day",      default: 3
    t.integer  "user_id"
    t.index ["user_id"], name: "index_customers_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string  "name"
    t.integer "protein"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "basket_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_orders_on_basket_id", using: :btree
  end

  create_table "sizes", force: :cascade do |t|
    t.string  "name"
    t.integer "kcal"
  end

  create_table "smoothies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "size_id"
    t.integer  "group_id"
    t.string   "image"
    t.string   "logo"
    t.text     "great_with"
    t.text     "ingredient_description"
    t.text     "story"
    t.text     "when"
    t.text     "benefits_one"
    t.text     "benefits_two"
    t.text     "benefits_three"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "postcode"
    t.boolean  "valid_postcode"
    t.boolean  "newsletter"
    t.boolean  "accepted_terms"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "basket_smoothies", "baskets"
  add_foreign_key "basket_smoothies", "smoothies"
  add_foreign_key "baskets", "customers"
  add_foreign_key "customers", "users"
  add_foreign_key "orders", "baskets"
  add_foreign_key "smoothies", "groups"
  add_foreign_key "smoothies", "sizes"
end
