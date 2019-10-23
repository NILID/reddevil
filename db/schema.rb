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

ActiveRecord::Schema.define(version: 20191023115238) do

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "ancestry"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestry"], name: "index_albums_on_ancestry", using: :btree
    t.index ["slug"], name: "index_albums_on_slug", unique: true, using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
    t.boolean  "hidden",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  end

  create_table "categoryships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "doc_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categoryships_on_category_id", using: :btree
    t.index ["doc_id"], name: "index_categoryships_on_doc_id", using: :btree
  end

  create_table "datasets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "src_file_name"
    t.string   "src_content_type"
    t.bigint   "src_file_size"
    t.datetime "src_updated_at"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["folder_id"], name: "index_datasets_on_folder_id", using: :btree
    t.index ["user_id"], name: "index_datasets_on_user_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "docs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "desc",              limit: 65535
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.bigint   "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "show_last_flag",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",    limit: 65535
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestry"], name: "index_folders_on_ancestry", using: :btree
    t.index ["user_id"], name: "index_folders_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "forecasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "team1goal"
    t.integer  "team2goal"
    t.integer  "winner_id"
    t.string   "ending",     default: "basic"
    t.boolean  "full_guess", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["match_id"], name: "index_forecasts_on_match_id", using: :btree
    t.index ["user_id"], name: "index_forecasts_on_user_id", using: :btree
    t.index ["winner_id"], name: "index_forecasts_on_winner_id", using: :btree
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
    t.index ["liker_id", "liker_type"], name: "fk_likes", using: :btree
  end

  create_table "matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["round_id"], name: "index_matches_on_round_id", using: :btree
    t.index ["team1_id"], name: "index_matches_on_team1_id", using: :btree
    t.index ["team2_id"], name: "index_matches_on_team2_id", using: :btree
    t.index ["winner_id"], name: "index_matches_on_winner_id", using: :btree
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.date     "birth"
    t.string   "email"
    t.bigint   "phone"
    t.string   "short_number"
    t.bigint   "work_phone"
    t.boolean  "archive_flag", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "mentions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",    limit: 65535
    t.boolean  "close",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",                 limit: 65535
    t.string   "status",                                default: "new"
    t.text     "review",                  limit: 65535
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.bigint   "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "login"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.bigint   "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "background_color",    default: "#aecdf2"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.integer  "total_result",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "total",      default: 0
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["round_id"], name: "index_results_on_round_id", using: :btree
    t.index ["user_id"], name: "index_results_on_user_id", using: :btree
  end

  create_table "room_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["room_id"], name: "index_room_messages_on_room_id", using: :btree
    t.index ["user_id"], name: "index_room_messages_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "private",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "index_rooms_on_name", using: :btree
    t.index ["user_id"], name: "index_rooms_on_user_id", using: :btree
  end

  create_table "rooms_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.index ["room_id"], name: "index_rooms_users_on_room_id", using: :btree
    t.index ["user_id"], name: "index_rooms_users_on_user_id", using: :btree
  end

  create_table "rounds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "songs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "album_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.bigint   "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["album_id"], name: "index_songs_on_album_id", using: :btree
  end

  create_table "subscribes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fullname"
    t.string   "departament"
    t.text     "position",    limit: 65535
    t.string   "place"
    t.string   "phone_inter"
    t.string   "phone_city"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "type_id"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.bigint   "flag_file_size"
    t.datetime "flag_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["type_id"], name: "index_teams_on_type_id", using: :btree
  end

  create_table "types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "roles_mask",             default: 64
    t.integer  "groups_mask",            default: 1
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "sport_flag",             default: false
    t.integer  "forecasts_count"
    t.integer  "win_forecasts_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "vacations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "startdate",  null: false
    t.datetime "enddate",    null: false
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_vacations_on_member_id", using: :btree
  end

  add_foreign_key "categoryships", "categories"
  add_foreign_key "categoryships", "docs"
  add_foreign_key "forecasts", "matches"
  add_foreign_key "forecasts", "users"
  add_foreign_key "members", "users"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "room_messages", "users"
  add_foreign_key "rooms", "users"
  add_foreign_key "rooms_users", "rooms"
  add_foreign_key "rooms_users", "users"
  add_foreign_key "vacations", "members"
end
