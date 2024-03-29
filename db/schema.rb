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

ActiveRecord::Schema.define(:version => 20131108125956) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "credits"
    t.string   "logo"
    t.string   "slug"
    t.boolean  "safe_job_seal",    :default => false
    t.boolean  "active",           :default => true
    t.string   "role"
    t.string   "business_type"
    t.integer  "invite_credits",   :default => 25
    t.integer  "estimate_credits", :default => 100
  end

  create_table "activities", :force => true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ad_stats", :force => true do |t|
    t.integer  "advertisement_id"
    t.integer  "clicks",           :default => 0
    t.integer  "impressions",      :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.date     "date"
    t.string   "status",           :default => "unbilled"
  end

  create_table "ad_targetings", :force => true do |t|
    t.integer  "ad_target_id"
    t.integer  "campaign_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "ad_targets", :force => true do |t|
    t.string   "name"
    t.string   "audience"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "advertisements", :force => true do |t|
    t.string   "title",                                 :null => false
    t.string   "url"
    t.integer  "campaign_id"
    t.text     "content"
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "priority",           :default => 1
    t.boolean  "confirmed",          :default => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",             :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "ad_type"
    t.text     "image_meta"
    t.integer  "impression_count",   :default => 0
    t.integer  "click_count",        :default => 0
  end

  create_table "advertiser_accounts", :force => true do |t|
    t.string   "company"
    t.string   "website"
    t.string   "phone"
    t.integer  "credits",    :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "advertiser_charges", :force => true do |t|
    t.integer  "advertiser_invoice_id"
    t.integer  "amount_cents",          :default => 0,     :null => false
    t.string   "amount_currency",       :default => "USD", :null => false
    t.string   "description"
    t.integer  "quantity"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "campaign_id"
  end

  create_table "advertiser_invoices", :force => true do |t|
    t.string   "guid"
    t.string   "stripe_charge_id"
    t.integer  "advertiser_account_id"
    t.integer  "amount_cents",          :default => 0,     :null => false
    t.string   "amount_currency",       :default => "USD", :null => false
    t.string   "description"
    t.string   "state"
    t.string   "error"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "answers", :force => true do |t|
    t.string   "text"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "applicant_accesses", :force => true do |t|
    t.integer  "account_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "applicable_id"
    t.string   "applicable_type"
    t.boolean  "hourly",          :default => true
    t.integer  "job_id"
  end

  add_index "applicant_accesses", ["account_id"], :name => "index_applicant_accesses_on_account_id"
  add_index "applicant_accesses", ["applicable_id", "applicable_type"], :name => "index_applicant_accesses_on_applicable_id_and_applicable_type"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "subtitle"
    t.integer  "view_count",         :default => 0
    t.integer  "blog_category_id"
  end

  create_table "blocks", :force => true do |t|
    t.integer  "blocker_id"
    t.integer  "blocked_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blog_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.integer  "advertiser_account_id"
    t.boolean  "active",                :default => false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "max_bid_cents",         :default => 0,     :null => false
    t.string   "max_bid_currency",      :default => "USD", :null => false
    t.integer  "budget_cents",          :default => 0,     :null => false
    t.string   "budget_currency",       :default => "USD", :null => false
    t.boolean  "cpc",                   :default => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "confirmations", :force => true do |t|
    t.text     "message"
    t.string   "email"
    t.integer  "confirm_for"
    t.integer  "confirm_by"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent"
    t.datetime "confirmated_at"
    t.integer  "confirmable_id"
    t.string   "confirmable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "conversation_items", :force => true do |t|
    t.text     "body"
    t.integer  "sender_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "conversation_id"
    t.boolean  "draft",           :default => false
  end

  create_table "conversations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "subject"
  end

  create_table "credit_packages", :force => true do |t|
    t.string   "name"
    t.decimal  "cost",       :precision => 6, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "credit_transactions", :force => true do |t|
    t.decimal  "amount",             :precision => 8, :scale => 2
    t.string   "description"
    t.integer  "quantity"
    t.integer  "account_id"
    t.integer  "credit_package_id"
    t.integer  "payment_profile_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "credit_transactions", ["account_id"], :name => "index_credit_transactions_on_account_id"
  add_index "credit_transactions", ["credit_package_id"], :name => "index_credit_transactions_on_credit_package_id"
  add_index "credit_transactions", ["payment_profile_id"], :name => "index_credit_transactions_on_payment_method_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "email_subscriptions", :force => true do |t|
    t.string   "query"
    t.string   "location"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "estimate_items", :force => true do |t|
    t.integer  "estimate_id"
    t.string   "task"
    t.integer  "hours"
    t.integer  "total_cents",    :default => 0,     :null => false
    t.string   "total_currency", :default => "USD", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "estimate_items", ["estimate_id"], :name => "index_estimate_items_on_estimate_id"

  create_table "estimates", :force => true do |t|
    t.integer  "job_id"
    t.integer  "resume_id"
    t.text     "terms"
    t.text     "notes"
    t.string   "state"
    t.date     "due_date"
    t.date     "start_date"
    t.boolean  "pre_fund"
    t.integer  "total_cents",    :default => 0,     :null => false
    t.string   "total_currency", :default => "USD", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "estimates", ["job_id"], :name => "index_estimates_on_job_id"
  add_index "estimates", ["resume_id"], :name => "index_estimates_on_resume_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.date     "start"
    t.integer  "user_id"
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
    t.string   "industry"
  end

  create_table "invites", :force => true do |t|
    t.integer  "job_id"
    t.integer  "resume_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invoices", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "reciever_id"
    t.integer  "project_id"
    t.string   "guid"
    t.string   "stripe_charge_id"
    t.string   "description"
    t.string   "error"
    t.integer  "amount_cents",     :default => 0,     :null => false
    t.string   "amount_currency",  :default => "USD", :null => false
    t.string   "state"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "escrow",           :default => false
  end

  create_table "job_applications", :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "note",       :default => "Have not spoken to"
  end

  add_index "job_applications", ["job_id"], :name => "index_job_applications_on_job_id"
  add_index "job_applications", ["user_id"], :name => "index_job_applications_on_user_id"

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "about_company"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "account_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.boolean  "active",                 :default => true
    t.integer  "job_applications_count", :default => 0
    t.integer  "category_id"
    t.boolean  "quick_applicable",       :default => true
    t.boolean  "invite_only",            :default => true
    t.integer  "category2_id"
    t.integer  "category3_id"
    t.boolean  "invited",                :default => false
    t.string   "yearly_compensation"
    t.string   "merit_requested"
    t.integer  "rating"
    t.string   "job_type"
  end

  add_index "jobs", ["account_id"], :name => "index_jobs_on_account_id"
  add_index "jobs", ["active"], :name => "index_jobs_on_active"
  add_index "jobs", ["quick_applicable"], :name => "index_jobs_on_quick_applicable"
  add_index "jobs", ["rating"], :name => "index_jobs_on_rating"

  create_table "jobs_skills", :id => false, :force => true do |t|
    t.integer "job_id"
    t.integer "skill_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "invoice_id"
    t.integer  "task_id"
    t.integer  "rate_cents",     :default => 0,     :null => false
    t.string   "rate_currency",  :default => "USD", :null => false
    t.integer  "hours"
    t.string   "note"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "total_cents",    :default => 0,     :null => false
    t.string   "total_currency", :default => "USD", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "participants", :force => true do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "payment_profiles", :force => true do |t|
    t.string   "stripe_customer_token"
    t.string   "nickname"
    t.string   "expiration"
    t.string   "cc_number_preview"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "status"
    t.integer  "accountable_id"
    t.string   "accountable_type"
  end

  add_index "payment_profiles", ["accountable_id", "accountable_type"], :name => "index_payment_profiles_on_accountable_id_and_accountable_type"

  create_table "profiles", :force => true do |t|
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
  end

  create_table "project_documents", :force => true do |t|
    t.integer  "project_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner_id"
    t.integer  "job_id"
  end

  add_index "projects", ["job_id"], :name => "index_projects_on_job_id"
  add_index "projects", ["owner_id"], :name => "index_projects_on_owner_id"

  create_table "projects_users", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["job_id"], :name => "index_questions_on_job_id"

  create_table "references", :force => true do |t|
    t.string   "name"
    t.string   "job_title"
    t.string   "company"
    t.string   "phone"
    t.string   "email"
    t.text     "notes"
    t.string   "reference_type"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "resume_id"
    t.boolean  "confirmed",      :default => false
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "twitter"
    t.integer  "user_id"
    t.string   "web_video"
    t.string   "video"
    t.integer  "category1_id"
    t.integer  "category2_id"
    t.integer  "category3_id"
    t.integer  "rating"
    t.boolean  "private",             :default => false
    t.string   "resume_type"
  end

  add_index "resumes", ["rating"], :name => "index_resumes_on_rating"

  create_table "resumes_skills", :id => false, :force => true do |t|
    t.integer "resume_id"
    t.integer "skill_id"
  end

  create_table "scam_reports", :force => true do |t|
    t.string   "scammer_type"
    t.string   "name_used"
    t.string   "email_used"
    t.string   "reporter_ip"
    t.integer  "user_id"
    t.string   "phone_number_used"
    t.text     "any_additional_info"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
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
    t.string   "course_of_study"
    t.string   "highest_merit"
    t.integer  "completion_year"
  end

  create_table "seal_purchases", :force => true do |t|
    t.integer  "account_id"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shifts", :force => true do |t|
    t.integer  "employee_id"
    t.date     "schedule_date"
    t.datetime "start_hour"
    t.datetime "end_hour"
    t.integer  "creator_id"
    t.integer  "shift_hours"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "shifts", ["creator_id"], :name => "index_shifts_on_creator_id"
  add_index "shifts", ["employee_id"], :name => "index_shifts_on_employee_id"
  add_index "shifts", ["schedule_date"], :name => "index_shifts_on_schedule_date"

  create_table "skill_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.integer  "skill_group_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "staffs", :force => true do |t|
    t.integer  "staffer_id"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "due_date"
    t.string   "state"
    t.integer  "position"
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["state"], :name => "index_tasks_on_state"

  create_table "timesheet_entries", :force => true do |t|
    t.integer  "timesheet_id"
    t.date     "date"
    t.decimal  "hours",        :precision => 3, :scale => 1, :default => 0.0
    t.string   "note"
    t.integer  "task_id"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "timesheet_entries", ["task_id"], :name => "index_timesheet_entries_on_task_id"
  add_index "timesheet_entries", ["timesheet_id"], :name => "index_timesheet_entries_on_timesheet_id"

  create_table "timesheets", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "status",     :default => "unpaid"
  end

  add_index "timesheets", ["project_id"], :name => "index_timesheets_on_project_id"
  add_index "timesheets", ["user_id"], :name => "index_timesheets_on_user_id"

  create_table "todos", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.date     "date"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "position"
    t.boolean  "done",       :default => false
  end

  add_index "todos", ["user_id"], :name => "index_todos_on_user_id"

  create_table "tweets", :force => true do |t|
    t.text     "body"
    t.boolean  "for_accounts"
    t.boolean  "for_public"
    t.boolean  "for_resumes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "subject"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "account_id"
    t.boolean  "admin"
    t.boolean  "moderator",              :default => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "advertiser",             :default => false
    t.text     "target_params"
    t.string   "role"
    t.string   "stripe_recipient_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "validation_requests", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "ein"
    t.string   "ssn"
    t.string   "industry"
    t.string   "length_of_business"
    t.boolean  "commission_only"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.boolean  "profit",                                  :default => false
    t.string   "contact_person"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.boolean  "independent_distributorship_opportunity", :default => false
  end

  add_index "validation_requests", ["account_id"], :name => "index_validation_requests_on_account_id"

  create_table "video_chat_messages", :force => true do |t|
    t.integer  "video_chat_id"
    t.integer  "sender_id"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "video_chats", :force => true do |t|
    t.integer  "requester_id"
    t.integer  "recipient_id"
    t.boolean  "accepted_by_requester"
    t.boolean  "accepted_by_recipient"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.text     "note"
  end

end
