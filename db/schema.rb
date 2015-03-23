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

ActiveRecord::Schema.define(version: 20150321165746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calls", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "description"
    t.text     "instructions"
    t.string   "website_url"
    t.datetime "opens_at"
    t.datetime "closes_at",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phase"
    t.boolean  "archived",     default: false
  end

  add_index "calls", ["title"], name: "index_calls_on_title", unique: true, using: :btree

  create_table "communications", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "call_id"
  end

  add_index "communications", ["created_at"], name: "index_communications_on_created_at", using: :btree
  add_index "communications", ["sender_id"], name: "index_communications_on_sender_id", using: :btree

  create_table "communications_recipients", id: false, force: :cascade do |t|
    t.integer "communication_id"
    t.integer "recipient_id"
  end

  add_index "communications_recipients", ["communication_id", "recipient_id"], name: "c_id_rec_id", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "proposals", id: false, force: :cascade do |t|
    t.string   "id",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",   default: false, null: false
    t.string   "track"
    t.integer  "call_id",                    null: false
    t.string   "talk_id"
  end

  create_table "proposed_speakers", force: :cascade do |t|
    t.integer  "inviter_id"
    t.integer  "call_id"
    t.string   "speaker_name"
    t.string   "speaker_email"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposed_speakers", ["call_id"], name: "index_proposed_speakers_on_call_id", using: :btree
  add_index "proposed_speakers", ["inviter_id"], name: "index_proposed_speakers_on_inviter_id", using: :btree

  create_table "rating_dimensions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_proposal_rating_id", null: false
    t.integer  "rating_dimension_id",     null: false
    t.integer  "vote"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["user_proposal_rating_id", "rating_dimension_id"], name: "i_ratings_on_user_paper_rating_id_and_rating_dimension_id", unique: true, using: :btree

  create_table "talks", id: false, force: :cascade do |t|
    t.string   "id",                                 null: false
    t.string   "title",                              null: false
    t.string   "public_description"
    t.string   "private_description",                null: false
    t.string   "time_slot"
    t.string   "track"
    t.string   "mentor_name"
    t.boolean  "mentors_can_read",    default: true, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",                            null: false
  end

  add_index "talks", ["mentors_can_read"], name: "index_talks_on_mentors_can_read", using: :btree

  create_table "user_proposal_ratings", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.string   "proposal_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_proposal_ratings", ["user_id", "proposal_id"], name: "index_user_proposal_ratings_on_user_id_and_proposal_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "email",                                  null: false
    t.text     "bio"
    t.string   "website_url"
    t.string   "twitter_handle"
    t.string   "github_handle"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "staff"
    t.boolean  "mentor",                 default: false
    t.integer  "gender"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "authentications", "users", on_delete: :cascade
  add_foreign_key "proposals", "calls", on_delete: :restrict
  add_foreign_key "talks", "users"
end
