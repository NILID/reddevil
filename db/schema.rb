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

ActiveRecord::Schema.define(version: 2020_02_18_084023) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.date "deadline"
    t.string "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "fk_rails_7e11bb717f"
  end

  create_table "albums", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "ancestry"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestry"], name: "index_albums_on_ancestry"
    t.index ["slug"], name: "index_albums_on_slug", unique: true
  end

  create_table "cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_cards_on_category_id"
  end

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.boolean "hidden", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "flag"
    t.integer "position", default: 0
    t.string "show_type"
    t.string "color", default: "#ccc"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "categoryships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "doc_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categoryships_on_category_id"
    t.index ["doc_id"], name: "index_categoryships_on_doc_id"
  end

  create_table "columns", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "column_type"
    t.integer "table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "columnships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "column_id"
    t.integer "row_id"
    t.text "data"
    t.text "desc"
    t.index ["column_id"], name: "index_columnships_on_column_id"
    t.index ["row_id"], name: "index_columnships_on_row_id"
  end

  create_table "datasets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "src_file_name"
    t.string "src_content_type"
    t.bigint "src_file_size"
    t.datetime "src_updated_at"
    t.integer "user_id"
    t.integer "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["folder_id"], name: "index_datasets_on_folder_id"
    t.index ["user_id"], name: "index_datasets_on_user_id"
  end

  create_table "delayed_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "docs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.boolean "show_last_flag", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "folders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestry"], name: "index_folders_on_ancestry"
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "follows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "follower_type"
    t.integer "follower_id"
    t.string "followable_type"
    t.integer "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "forecasts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "match_id"
    t.integer "team1goal"
    t.integer "team2goal"
    t.integer "winner_id"
    t.string "ending", default: "basic"
    t.boolean "full_guess", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["match_id"], name: "index_forecasts_on_match_id"
    t.index ["user_id"], name: "index_forecasts_on_user_id"
    t.index ["winner_id"], name: "index_forecasts_on_winner_id"
  end

  create_table "friendly_id_slugs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "likes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "liker_type"
    t.integer "liker_id"
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables"
    t.index ["liker_id", "liker_type"], name: "fk_likes"
  end

  create_table "matches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "team1_id"
    t.integer "team2_id"
    t.integer "team1goal"
    t.integer "team2goal"
    t.integer "winner_id"
    t.string "ending", default: "basic"
    t.string "desc"
    t.integer "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["round_id"], name: "index_matches_on_round_id"
    t.index ["team1_id"], name: "index_matches_on_team1_id"
    t.index ["team2_id"], name: "index_matches_on_team2_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "members", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.date "birth"
    t.string "email"
    t.bigint "phone"
    t.string "short_number"
    t.bigint "work_phone"
    t.boolean "archive_flag", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "group"
    t.string "position"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "mentions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.string "mentionable_type"
    t.integer "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions"
  end

  create_table "messages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "close", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.string "status", default: "new"
    t.text "review"
    t.string "screenshot_file_name"
    t.string "screenshot_content_type"
    t.bigint "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "slug"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["user_id"], name: "fk_rails_84a58494eb"
  end

  create_table "profiles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "background_color", default: "#aecdf2"
    t.integer "total_result", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "results", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "total", default: 0
    t.integer "user_id"
    t.integer "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["round_id"], name: "index_results_on_round_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "room_messages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_messages_on_room_id"
    t.index ["user_id"], name: "index_room_messages_on_user_id"
  end

  create_table "rooms", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.boolean "private", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_rooms_on_name"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "rooms_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.index ["room_id"], name: "index_rooms_users_on_room_id"
    t.index ["user_id"], name: "index_rooms_users_on_user_id"
  end

  create_table "rounds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.boolean "close", default: false
    t.datetime "deadline"
    t.integer "type_id"
    t.boolean "empty_match", default: false
    t.boolean "draw", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
    t.index ["table_id"], name: "index_rows_on_table_id"
    t.index ["user_id"], name: "index_rows_on_user_id"
  end

  create_table "songs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "album_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["album_id"], name: "index_songs_on_album_id"
  end

  create_table "subfiles", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "src_file_name"
    t.string "src_content_type"
    t.bigint "src_file_size"
    t.datetime "src_updated_at"
    t.bigint "substrate_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["substrate_id"], name: "index_subfiles_on_substrate_id"
    t.index ["user_id"], name: "index_subfiles_on_user_id"
  end

  create_table "subscribes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fullname"
    t.string "departament"
    t.text "position"
    t.string "place"
    t.string "phone_inter"
    t.string "phone_city"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "substrates", id: :bigint, default: nil, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "drawing"
    t.string "detail"
    t.integer "amount", default: 1
    t.string "contract"
    t.date "arrival_at"
    t.string "arrival_from"
    t.date "shipping_at"
    t.string "shipping_to"
    t.string "shipping_base"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "priority", default: "normal"
    t.string "title"
    t.text "desc"
    t.string "coating_type", default: "нет"
    t.string "wave"
    t.string "corner"
    t.boolean "frame", default: false
    t.integer "statuses_mask", default: 0
    t.string "propotions"
    t.string "sides"
    t.datetime "finished_at"
    t.datetime "future_shipping_at"
    t.string "coating_type_b", default: "нет"
    t.string "wave_b"
    t.string "corner_b"
    t.integer "instock", default: 0
    t.integer "priorityx", default: 4, null: false
    t.integer "ready_count", default: 0
    t.index ["user_id"], name: "index_substrates_on_user_id"
  end

  create_table "substrates_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "substrate_id"
    t.integer "user_id"
    t.index ["substrate_id"], name: "index_substrates_users_on_substrate_id"
    t.index ["user_id"], name: "index_substrates_users_on_user_id"
  end

  create_table "tables", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "tableable_id"
    t.string "tableable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tableable_id", "tableable_type"], name: "index_tables_on_tableable_id_and_tableable_type"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "teams", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "type_id"
    t.string "flag_file_name"
    t.string "flag_content_type"
    t.bigint "flag_file_size"
    t.datetime "flag_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["type_id"], name: "index_teams_on_type_id"
  end

  create_table "types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "roles_mask", default: 64
    t.integer "groups_mask", default: 1
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "sport_flag", default: false
    t.integer "forecasts_count"
    t.integer "win_forecasts_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vacations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "startdate", null: false
    t.datetime "enddate", null: false
    t.integer "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_vacations_on_member_id"
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.text "object_changes", limit: 4294967295
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "users"
  add_foreign_key "cards", "categories"
  add_foreign_key "categoryships", "categories"
  add_foreign_key "categoryships", "docs"
  add_foreign_key "forecasts", "matches"
  add_foreign_key "forecasts", "users"
  add_foreign_key "members", "users"
  add_foreign_key "pages", "users"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "room_messages", "users"
  add_foreign_key "rooms", "users"
  add_foreign_key "rooms_users", "rooms"
  add_foreign_key "rooms_users", "users"
  add_foreign_key "vacations", "members"
end
