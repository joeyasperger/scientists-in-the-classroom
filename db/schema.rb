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

ActiveRecord::Schema.define(version: 20160229044758) do

  create_table "matches", force: :cascade do |t|
    t.integer  "scientist_id"
    t.integer  "teacher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "matches", ["scientist_id"], name: "index_matches_on_scientist_id"
  add_index "matches", ["teacher_id"], name: "index_matches_on_teacher_id"

  create_table "scientists", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "email"
    t.string   "phone"
    t.string   "communication_method"
    t.string   "occupation"
    t.string   "education"
    t.string   "affiliation"
    t.boolean  "evolution"
    t.boolean  "climate_change"
    t.string   "specialization"
    t.string   "experience"
    t.string   "goals"
    t.string   "availability"
    t.boolean  "committed"
    t.boolean  "less_than_30"
    t.string   "link"
    t.boolean  "read_expectations"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "zip_code"
    t.decimal  "lat"
    t.decimal  "lng"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "email"
    t.string   "phone"
    t.string   "school"
    t.string   "communication_method"
    t.string   "grade"
    t.string   "topics"
    t.string   "class_times"
    t.boolean  "climate_change"
    t.boolean  "evolution"
    t.string   "topics_to_cover"
    t.string   "benefits"
    t.string   "requirements"
    t.boolean  "read_expectations"
    t.boolean  "approved"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "zip_code"
    t.decimal  "lat"
    t.decimal  "lng"
  end

end
