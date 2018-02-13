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

ActiveRecord::Schema.define(version: 20180213054837) do

  create_table "albums", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "ancestry",   limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "albums", ["ancestry"], name: "index_albums_on_ancestry", using: :btree
  add_index "albums", ["slug"], name: "index_albums_on_slug", unique: true, using: :btree

  create_table "arts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "ancestry",       limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "ancestry_depth", limit: 4,   default: 0
    t.boolean  "hidden",                     default: false
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree

  create_table "categoryships", force: :cascade do |t|
    t.integer "doc_id",      limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "categoryships", ["category_id"], name: "index_categoryships_on_category_id", using: :btree
  add_index "categoryships", ["doc_id"], name: "index_categoryships_on_doc_id", using: :btree

  create_table "columns", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "column_type", limit: 255
    t.integer  "year_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "columns", ["year_id"], name: "index_columns_on_year_id", using: :btree

  create_table "columnships", force: :cascade do |t|
    t.integer "column_id",   limit: 4
    t.integer "purchase_id", limit: 4
    t.text    "data",        limit: 65535
    t.text    "desc",        limit: 65535
  end

  add_index "columnships", ["column_id"], name: "index_columnships_on_column_id", using: :btree
  add_index "columnships", ["purchase_id"], name: "index_columnships_on_purchase_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "datasets", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "src_file_name",    limit: 255
    t.string   "src_content_type", limit: 255
    t.integer  "src_file_size",    limit: 4
    t.datetime "src_updated_at"
    t.integer  "user_id",          limit: 4
    t.integer  "folder_id",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "datasets", ["folder_id"], name: "index_datasets_on_folder_id", using: :btree
  add_index "datasets", ["user_id"], name: "index_datasets_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "deliveries", force: :cascade do |t|
    t.datetime "doc"
    t.datetime "delivery"
    t.integer  "purchase_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "deliveries", ["purchase_id"], name: "index_deliveries_on_purchase_id", using: :btree

  create_table "docs", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "desc",              limit: 65535
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "category_id",       limit: 4
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "ancestry",       limit: 255
    t.integer  "ancestry_depth", limit: 4,   default: 0
  end

  add_index "folders", ["ancestry"], name: "index_folders_on_ancestry", using: :btree
  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type",   limit: 255
    t.integer  "follower_id",     limit: 4
    t.string   "followable_type", limit: 255
    t.integer  "followable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "forecasts", force: :cascade do |t|
    t.integer  "tempuser_id", limit: 4
    t.integer  "match_id",    limit: 4
    t.integer  "team1goal",   limit: 4
    t.integer  "team2goal",   limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "winner_id",   limit: 4
    t.string   "ending",      limit: 255, default: "basic"
    t.integer  "user_id",     limit: 4
  end

  add_index "forecasts", ["match_id"], name: "index_forecasts_on_match_id", using: :btree
  add_index "forecasts", ["tempuser_id"], name: "index_forecasts_on_tempuser_id", using: :btree
  add_index "forecasts", ["user_id"], name: "index_forecasts_on_user_id", using: :btree
  add_index "forecasts", ["winner_id"], name: "index_forecasts_on_winner_id", using: :btree

  create_table "holidays", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "holidays", ["member_id"], name: "index_holidays_on_member_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type",    limit: 255
    t.integer  "liker_id",      limit: 4
    t.string   "likeable_type", limit: 255
    t.integer  "likeable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "machines", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "team1_id",   limit: 4
    t.integer  "team2_id",   limit: 4
    t.integer  "team1goal",  limit: 4
    t.integer  "team2goal",  limit: 4
    t.integer  "round_id",   limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "winner_id",  limit: 4
    t.string   "ending",     limit: 255, default: "basic"
    t.string   "desc",       limit: 255
  end

  add_index "matches", ["round_id"], name: "index_matches_on_round_id", using: :btree
  add_index "matches", ["team1_id"], name: "index_matches_on_team1_id", using: :btree
  add_index "matches", ["team2_id"], name: "index_matches_on_team2_id", using: :btree
  add_index "matches", ["winner_id"], name: "index_matches_on_winner_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "content",     limit: 65535
    t.integer  "groups_mask", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "materials", ["user_id"], name: "index_materials_on_user_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "surname",      limit: 255
    t.string   "patronymic",   limit: 255
    t.date     "birth"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "email",        limit: 255
    t.integer  "phone",        limit: 8
    t.string   "short_number", limit: 255
  end

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type",   limit: 255
    t.integer  "mentioner_id",     limit: 4
    t.string   "mentionable_type", limit: 255
    t.integer  "mentionable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.boolean  "close",                    default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "mirrors", force: :cascade do |t|
    t.integer "weight",    limit: 4
    t.integer "real",      limit: 4
    t.integer "second_id", limit: 4
  end

  create_table "notes", force: :cascade do |t|
    t.text     "content",                 limit: 65535
    t.string   "status",                  limit: 255,   default: "new"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.text     "review",                  limit: 65535
    t.string   "screenshot_file_name",    limit: 255
    t.string   "screenshot_content_type", limit: 255
    t.integer  "screenshot_file_size",    limit: 4
    t.datetime "screenshot_updated_at"
    t.integer  "user_id",                 limit: 4
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "login",               limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "background_color",    limit: 255, default: "#aecdf2"
    t.string   "name",                limit: 255
    t.string   "surname",             limit: 255
    t.string   "patronymic",          limit: 255
    t.integer  "total_result",        limit: 4,   default: 0
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.float    "price",             limit: 24
    t.string   "provider",          limit: 255
    t.string   "doc",               limit: 255
    t.integer  "user_id",           limit: 4
    t.date     "startdate"
    t.date     "zkpdate"
    t.date     "kp"
    t.date     "zsc_kp"
    t.date     "nmc"
    t.date     "aztz"
    t.date     "conclusion_expert"
    t.date     "analytic"
    t.date     "conclusion_pdtk"
    t.date     "erp"
    t.date     "request"
    t.date     "bidding"
    t.date     "committee"
    t.date     "contract_request"
    t.date     "contract_project"
    t.date     "contract"
    t.date     "prepay_date"
    t.integer  "prepay_sum",        limit: 4
    t.date     "warmth_date"
    t.integer  "warmth_sum",        limit: 4
    t.date     "proxy"
    t.date     "delivery"
    t.integer  "year_id",           limit: 4
    t.string   "status",            limit: 255
    t.string   "status_color",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree
  add_index "purchases", ["year_id"], name: "index_purchases_on_year_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "total",       limit: 4, default: 0
    t.integer  "user_id",     limit: 4
    t.integer  "tempuser_id", limit: 4
    t.integer  "round_id",    limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "results", ["round_id"], name: "index_results_on_round_id", using: :btree
  add_index "results", ["tempuser_id"], name: "index_results_on_tempuser_id", using: :btree
  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "content",     limit: 255
    t.boolean  "close",                   default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.datetime "deadline"
    t.integer  "type_id",     limit: 4
    t.boolean  "empty_match",             default: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.integer  "album_id",          limit: 4
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id", using: :btree

  create_table "sources", force: :cascade do |t|
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.integer  "work_id",           limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "hide",                          default: false
  end

  add_index "sources", ["work_id"], name: "index_sources_on_work_id", using: :btree

  create_table "subscribes", force: :cascade do |t|
    t.string   "fullname",    limit: 255
    t.string   "departament", limit: 255
    t.text     "position",    limit: 65535
    t.string   "place",       limit: 255
    t.string   "phone_inter", limit: 255
    t.string   "phone_city",  limit: 255
    t.string   "email",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "substrates", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "drawing",      limit: 255
    t.string   "number",       limit: 255
    t.string   "state",        limit: 255
    t.integer  "user_id",      limit: 4
    t.text     "desc",         limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "theme",        limit: 255
    t.integer  "place",        limit: 4
    t.string   "category",     limit: 255,   null: false
    t.integer  "substrate_id", limit: 4
  end

  add_index "substrates", ["substrate_id"], name: "index_substrates_on_substrate_id", using: :btree
  add_index "substrates", ["user_id"], name: "index_substrates_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "machine_id", limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "complete",   limit: 4,   default: 0, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "tasks", ["machine_id"], name: "index_tasks_on_machine_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "content",           limit: 255
    t.integer  "type_id",           limit: 4
    t.string   "flag_file_name",    limit: 255
    t.string   "flag_content_type", limit: 255
    t.integer  "flag_file_size",    limit: 4
    t.datetime "flag_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "teams", ["type_id"], name: "index_teams_on_type_id", using: :btree

  create_table "tempusers", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id",      limit: 4
    t.integer  "total_result", limit: 4,   default: 0
  end

  add_index "tempusers", ["user_id"], name: "index_tempusers_on_user_id", using: :btree

  create_table "types", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "roles_mask",             limit: 4
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "groups_mask",            limit: 4,   default: 1
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "works", force: :cascade do |t|
    t.text     "desc",       limit: 65535
    t.integer  "art_id",     limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "works", ["art_id"], name: "index_works_on_art_id", using: :btree
  add_index "works", ["user_id"], name: "index_works_on_user_id", using: :btree

  create_table "years", force: :cascade do |t|
    t.string   "year",       limit: 255
    t.string   "slug",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "years", ["slug"], name: "index_years_on_slug", unique: true, using: :btree

  add_foreign_key "categoryships", "categories"
  add_foreign_key "categoryships", "docs"
  add_foreign_key "forecasts", "users"
end
