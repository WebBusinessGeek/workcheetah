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

ActiveRecord::Schema.define(:version => 20130417220911) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "credits"
    t.string   "logo"
    t.string   "slug"
    t.boolean  "safe_job_seal", :default => false
  end

  create_table "addresses", :force => true do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "applicant_accesses", :force => true do |t|
    t.integer  "job_application_id"
    t.integer  "account_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "applicant_accesses", ["account_id"], :name => "index_applicant_accesses_on_account_id"
  add_index "applicant_accesses", ["job_application_id"], :name => "index_applicant_accesses_on_job_application_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "credit_packages", :force => true do |t|
    t.string   "name"
    t.decimal  "cost",       :precision => 6, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "credit_transactions", :force => true do |t|
    t.decimal  "amount",            :precision => 8, :scale => 2
    t.string   "description"
    t.integer  "quantity"
    t.integer  "account_id"
    t.integer  "credit_package_id"
    t.integer  "payment_method_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "credit_transactions", ["account_id"], :name => "index_credit_transactions_on_account_id"
  add_index "credit_transactions", ["credit_package_id"], :name => "index_credit_transactions_on_credit_package_id"
  add_index "credit_transactions", ["payment_method_id"], :name => "index_credit_transactions_on_payment_method_id"

  create_table "email_subscriptions", :force => true do |t|
    t.string   "query"
    t.string   "location"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "experiences", :force => true do |t|
    t.string   "company_name"
    t.string   "job_title"
    t.date     "from"
    t.date     "till"
    t.text     "highlights"
    t.integer  "resume_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "current_employer"
  end

  create_table "job_applications", :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "job_applications", ["job_id"], :name => "index_job_applications_on_job_id"
  add_index "job_applications", ["user_id"], :name => "index_job_applications_on_user_id"

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "about_company"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "account_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.integer  "job_applications_count", :default => 0
  end

  create_table "payment_profiles", :force => true do |t|
    t.integer  "account_id"
    t.string   "stripe_customer_token"
    t.string   "nickname"
    t.string   "expiration"
    t.string   "cc_number_preview"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "status"
  end

  add_index "payment_profiles", ["account_id"], :name => "index_payment_profiles_on_account_id"

  create_table "references", :force => true do |t|
    t.string   "name"
    t.string   "job_title"
    t.string   "company"
    t.string   "phone"
    t.string   "email"
    t.text     "notes"
    t.string   "reference_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "resume_id"
  end

  create_table "resumes", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "status"
    t.string   "growth_importance"
    t.string   "distance_importance"
    t.string   "freedom_importance"
    t.string   "pay_importance"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "twitter"
    t.integer  "user_id"
    t.string   "web_video"
    t.string   "video"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "degree_type"
    t.string   "degree_name"
    t.date     "from"
    t.date     "till"
    t.boolean  "currently_attending"
    t.text     "highlights"
    t.integer  "resume_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "account_id"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
