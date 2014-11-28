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

ActiveRecord::Schema.define(version: 20141127022739) do

  create_table "account_accounts", force: true do |t|
    t.integer  "user_id"
    t.decimal  "useable_balance", default: 0.0
    t.decimal  "balance",         default: 0.0
    t.decimal  "frozen_balance",  default: 0.0
    t.decimal  "total_estate",    default: 0.0
    t.integer  "uinfo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_histories", force: true do |t|
    t.string   "action"
    t.decimal  "amount",       precision: 14, scale: 2
    t.integer  "account_id"
    t.string   "account_name"
    t.string   "direction"
    t.string   "product_name"
    t.string   "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_invest_principals", force: true do |t|
    t.integer  "account_sub_invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "principal_number",      default: 0
  end

  create_table "account_invest_profits", force: true do |t|
    t.integer  "account_sub_invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount",         precision: 14, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profit_number",                                  default: 0
  end

  create_table "account_product_principals", force: true do |t|
    t.integer  "account_product_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount",      precision: 14, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "principal_number",                            default: 0
  end

  create_table "account_product_profits", force: true do |t|
    t.integer  "account_product_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount",      precision: 14, scale: 2
    t.decimal  "decimal",            precision: 14, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profit_number",                               default: 0
  end

  create_table "account_products", force: true do |t|
    t.string   "deposit_number"
    t.decimal  "total_amount",             precision: 12, scale: 2
    t.decimal  "annual_rate",              precision: 5,  scale: 2
    t.integer  "repayment_period"
    t.decimal  "each_repayment_amount",    precision: 12, scale: 2
    t.decimal  "free_invest_amount",       precision: 10, scale: 2
    t.decimal  "fixed_invest_amount",      precision: 10, scale: 2, default: 0.0
    t.date     "join_date"
    t.date     "expiring_date"
    t.string   "premature_redemption"
    t.integer  "fee",                                               default: 1
    t.string   "product_type",                                      default: "fixed"
    t.string   "stage",                                             default: "open"
    t.datetime "profit_date"
    t.datetime "principal_date"
    t.integer  "status",                                            default: 0
    t.integer  "min_limit",                                         default: 1000
    t.integer  "max_limit",                                         default: 100000
    t.string   "repayment_method",                                  default: "profit"
    t.integer  "each_repayment_period",                             default: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_profit_period",                             default: 0
    t.integer  "current_principal_period",                          default: 0
  end

  create_table "account_profits", force: true do |t|
    t.integer  "account_sub_invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_records", force: true do |t|
    t.string   "op_name"
    t.string   "op_action"
    t.string   "op_id"
    t.string   "operator"
    t.integer  "account_id"
    t.decimal  "account_balance_before"
    t.decimal  "account_balance_after"
    t.decimal  "op_amount",              precision: 12, scale: 2
    t.boolean  "op_result"
    t.integer  "op_result_code"
    t.string   "resource_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_sub_invests", force: true do |t|
    t.integer  "account_sub_product_id"
    t.string   "loan_number"
    t.decimal  "amount",                   precision: 14, scale: 2, default: 0.0
    t.integer  "status",                                            default: 0
    t.boolean  "onsale",                                            default: false
    t.decimal  "discount_rate",                                     default: 0.0
    t.integer  "account_product_id"
    t.decimal  "resell_price",             precision: 14, scale: 2, default: 0.0
    t.decimal  "remain_principal",         precision: 14, scale: 2, default: 0.0
    t.integer  "current_period",                                    default: 0
    t.decimal  "annual_rate",              precision: 6,  scale: 2, default: 0.0
    t.decimal  "fixed_pp_amount",          precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_profit_period",                             default: 0
    t.integer  "current_principal_period",                          default: 0
  end

  create_table "account_sub_products", force: true do |t|
    t.integer  "account_product_id"
    t.integer  "account_account_id"
    t.decimal  "total_amount",       default: 0.0
    t.string   "deposit_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "show_name"
    t.string   "login_name"
    t.string   "phone"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  add_index "employees", ["unlock_token"], name: "index_employees_on_unlock_token", unique: true

  create_table "employees_roles", force: true do |t|
    t.integer "employee_id"
    t.integer "role_id"
  end

  create_table "roles", force: true do |t|
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secures", force: true do |t|
    t.string   "pay_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "mobile",                 default: "", null: false
    t.string   "username"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
