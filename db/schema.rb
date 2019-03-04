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

ActiveRecord::Schema.define(version: 20180608050004) do

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.string   "ancestry"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["ancestry"], name: "index_albums_on_ancestry"
  add_index "albums", ["slug"], name: "index_albums_on_slug", unique: true

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
    t.boolean  "hidden",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry"

  create_table "categoryships", force: :cascade do |t|
    t.integer "doc_id"
    t.integer "category_id"
  end

  add_index "categoryships", ["category_id"], name: "index_categoryships_on_category_id"
  add_index "categoryships", ["doc_id"], name: "index_categoryships_on_doc_id"

  create_table "columns", force: :cascade do |t|
    t.string   "name"
    t.string   "column_type"
    t.integer  "year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "columns", ["year_id"], name: "index_columns_on_year_id"

  create_table "columnships", force: :cascade do |t|
    t.integer "column_id"
    t.integer "purchase_id"
    t.text    "data"
    t.text    "desc"
  end

  add_index "columnships", ["column_id"], name: "index_columnships_on_column_id"
  add_index "columnships", ["purchase_id"], name: "index_columnships_on_purchase_id"

  create_table "datasets", force: :cascade do |t|
    t.string   "title"
    t.string   "src_file_name"
    t.string   "src_content_type"
    t.integer  "src_file_size",    limit: 8
    t.datetime "src_updated_at"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datasets", ["folder_id"], name: "index_datasets_on_folder_id"
  add_index "datasets", ["user_id"], name: "index_datasets_on_user_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "deliveries", force: :cascade do |t|
    t.datetime "doc"
    t.datetime "delivery"
    t.integer  "purchase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deliveries", ["purchase_id"], name: "index_deliveries_on_purchase_id"

  create_table "docs", force: :cascade do |t|
    t.string   "title"
    t.text     "desc"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size",    limit: 8
    t.datetime "file_updated_at"
    t.boolean  "show_last_flag",              default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "folders", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["ancestry"], name: "index_folders_on_ancestry"
  add_index "folders", ["user_id"], name: "index_folders_on_user_id"

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "forecasts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "team1goal"
    t.integer  "team2goal"
    t.integer  "winner_id"
    t.string   "ending",     default: "basic"
    t.boolean  "full_guess", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forecasts", ["match_id"], name: "index_forecasts_on_match_id"
  add_index "forecasts", ["user_id"], name: "index_forecasts_on_user_id"
  add_index "forecasts", ["winner_id"], name: "index_forecasts_on_winner_id"

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables"
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes"

  create_table "machines", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "team1goal"
    t.integer  "team2goal"
    t.integer  "winner_id"
    t.string   "ending",     default: "basic"
    t.string   "desc"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["round_id"], name: "index_matches_on_round_id"
  add_index "matches", ["team1_id"], name: "index_matches_on_team1_id"
  add_index "matches", ["team2_id"], name: "index_matches_on_team2_id"
  add_index "matches", ["winner_id"], name: "index_matches_on_winner_id"

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.date     "birth"
    t.string   "email"
    t.integer  "phone",        limit: 8
    t.string   "short_number"
    t.integer  "work_phone",   limit: 8
    t.boolean  "archive_flag",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions"

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "close",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.text     "content"
    t.string   "status",                            default: "new"
    t.text     "review"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size",    limit: 8
    t.datetime "screenshot_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "login"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size",    limit: 8
    t.datetime "avatar_updated_at"
    t.string   "background_color",              default: "#aecdf2"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.integer  "total_result",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "purchases", force: :cascade do |t|
    t.string   "title"
    t.float    "price"
    t.string   "provider"
    t.string   "doc"
    t.integer  "user_id"
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
    t.integer  "prepay_sum"
    t.date     "warmth_date"
    t.integer  "warmth_sum"
    t.date     "proxy"
    t.date     "delivery"
    t.integer  "year_id"
    t.string   "status"
    t.string   "status_color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id"
  add_index "purchases", ["year_id"], name: "index_purchases_on_year_id"

  create_table "results", force: :cascade do |t|
    t.integer  "total",      default: 0
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["round_id"], name: "index_results_on_round_id"
  add_index "results", ["user_id"], name: "index_results_on_user_id"

  create_table "rounds", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.boolean  "close",       default: false
    t.datetime "deadline"
    t.integer  "type_id"
    t.boolean  "empty_match", default: false
    t.boolean  "draw",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.integer  "album_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size",    limit: 8
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id"

  create_table "subscribes", force: :cascade do |t|
    t.string   "fullname"
    t.string   "departament"
    t.text     "position"
    t.string   "place"
    t.string   "phone_inter"
    t.string   "phone_city"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context"
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type"
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "machine_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "complete",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["machine_id"], name: "index_tasks_on_machine_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "type_id"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size",    limit: 8
    t.datetime "flag_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["type_id"], name: "index_teams_on_type_id"

  create_table "types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "roles_mask"
    t.integer  "groups_mask",            default: 1
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "sport_flag",             default: true
    t.integer  "forecasts_count"
    t.integer  "win_forecasts_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "vacations", force: :cascade do |t|
    t.datetime "startdate",  null: false
    t.datetime "enddate",    null: false
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vacations", ["member_id"], name: "index_vacations_on_member_id"

  create_table "years", force: :cascade do |t|
    t.string   "year"
    t.string   "slug",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "years", ["slug"], name: "index_years_on_slug", unique: true

end
