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

ActiveRecord::Schema.define(:version => 20110110045509) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.integer  "shipment_id"
    t.string   "name"
    t.string   "code"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "occurred_at"
    t.datetime "notified_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_date"
    t.string   "event_time"
  end

  create_table "incoming_mails", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.string   "reply_to"
    t.string   "subject"
    t.text     "body"
    t.datetime "sent_at"
    t.datetime "processed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipments", :force => true do |t|
    t.integer  "incoming_mail_id"
    t.string   "name"
    t.string   "notes"
    t.string   "service"
    t.string   "tracking_number"
    t.string   "service_type"
    t.string   "origin_city"
    t.string   "origin_state"
    t.string   "origin_country"
    t.string   "destination_city"
    t.string   "destination_state"
    t.string   "destination_country"
    t.datetime "last_checked_at"
    t.datetime "delivery_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_error"
  end

end
