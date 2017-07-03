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

ActiveRecord::Schema.define(:version => 20170629052958) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "ancestry"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "albums", ["ancestry"], :name => "index_albums_on_ancestry"
  add_index "albums", ["slug"], :name => "index_albums_on_slug", :unique => true

  create_table "arts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deadline"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "ancestry"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "ancestry_depth", :default => 0
    t.boolean  "hidden",         :default => false
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "columns", :force => true do |t|
    t.string   "name"
    t.string   "column_type"
    t.integer  "year_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "columns", ["year_id"], :name => "index_columns_on_year_id"

  create_table "columnships", :force => true do |t|
    t.integer "column_id"
    t.integer "purchase_id"
    t.text    "data"
    t.text    "desc"
  end

  add_index "columnships", ["column_id"], :name => "index_columnships_on_column_id"
  add_index "columnships", ["purchase_id"], :name => "index_columnships_on_purchase_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "datasets", :force => true do |t|
    t.string   "title"
    t.string   "src_file_name"
    t.string   "src_content_type"
    t.integer  "src_file_size"
    t.datetime "src_updated_at"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "datasets", ["folder_id"], :name => "index_datasets_on_folder_id"
  add_index "datasets", ["user_id"], :name => "index_datasets_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
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

  create_table "deliveries", :force => true do |t|
    t.datetime "doc"
    t.datetime "delivery"
    t.integer  "purchase_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "deliveries", ["purchase_id"], :name => "index_deliveries_on_purchase_id"

  create_table "docs", :force => true do |t|
    t.string   "title"
    t.text     "desc"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "category_id"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "folders", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "folders", ["ancestry"], :name => "index_folders_on_ancestry"
  add_index "folders", ["user_id"], :name => "index_folders_on_user_id"

  create_table "follows", :force => true do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "forecasts", :force => true do |t|
    t.integer  "tempuser_id"
    t.integer  "match_id"
    t.integer  "team1goal"
    t.integer  "team2goal"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "winner_id"
    t.string   "ending",      :default => "basic"
  end

  add_index "forecasts", ["match_id"], :name => "index_forecasts_on_match_id"
  add_index "forecasts", ["tempuser_id"], :name => "index_forecasts_on_tempuser_id"
  add_index "forecasts", ["winner_id"], :name => "index_forecasts_on_winner_id"

  create_table "holidays", :force => true do |t|
    t.integer  "member_id"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "holidays", ["member_id"], :name => "index_holidays_on_member_id"

  create_table "items", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "likes", :force => true do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], :name => "fk_likeables"
  add_index "likes", ["liker_id", "liker_type"], :name => "fk_likes"

  create_table "machines", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "team1goal"
    t.integer  "team2goal"
    t.integer  "round_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "winner_id"
    t.string   "ending",     :default => "basic"
    t.string   "desc"
  end

  add_index "matches", ["round_id"], :name => "index_matches_on_round_id"
  add_index "matches", ["team1_id"], :name => "index_matches_on_team1_id"
  add_index "matches", ["team2_id"], :name => "index_matches_on_team2_id"
  add_index "matches", ["winner_id"], :name => "index_matches_on_winner_id"

  create_table "materials", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "groups_mask"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "materials", ["user_id"], :name => "index_materials_on_user_id"

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.date     "birth"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "email"
    t.integer  "phone",        :limit => 8
    t.string   "short_number"
  end

  create_table "mentions", :force => true do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], :name => "fk_mentionables"
  add_index "mentions", ["mentioner_id", "mentioner_type"], :name => "fk_mentions"

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "close",      :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "mirrors", :force => true do |t|
    t.integer "weight"
    t.integer "real"
    t.integer "second_id"
  end

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.string   "status",     :default => "new"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.text     "review"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "login"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "background_color",    :default => "#aecdf2"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.integer  "total_result",        :default => 0
  end

  create_table "purchases", :force => true do |t|
    t.string  "title"
    t.float   "price"
    t.string  "provider"
    t.string  "doc"
    t.integer "user_id"
    t.date    "startdate"
    t.date    "zkpdate"
    t.date    "kp"
    t.date    "zsc_kp"
    t.date    "nmc"
    t.date    "aztz"
    t.date    "conclusion_expert"
    t.date    "analytic"
    t.date    "conclusion_pdtk"
    t.date    "erp"
    t.date    "request"
    t.date    "bidding"
    t.date    "committee"
    t.date    "contract_request"
    t.date    "contract_project"
    t.date    "contract"
    t.date    "prepay_date"
    t.integer "prepay_sum"
    t.date    "warmth_date"
    t.integer "warmth_sum"
    t.date    "proxy"
    t.date    "delivery"
    t.integer "year_id"
    t.string  "status"
    t.string  "status_color"
  end

  add_index "purchases", ["user_id"], :name => "index_purchases_on_user_id"
  add_index "purchases", ["year_id"], :name => "index_purchases_on_year_id"

  create_table "results", :force => true do |t|
    t.integer  "total",       :default => 0
    t.integer  "user_id"
    t.integer  "tempuser_id"
    t.integer  "round_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "results", ["round_id"], :name => "index_results_on_round_id"
  add_index "results", ["tempuser_id"], :name => "index_results_on_tempuser_id"
  add_index "results", ["user_id"], :name => "index_results_on_user_id"

  create_table "rounds", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.boolean  "close",       :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "deadline"
    t.integer  "type_id"
    t.boolean  "empty_match", :default => false
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.integer  "album_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "songs", ["album_id"], :name => "index_songs_on_album_id"

  create_table "sources", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "work_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "hide",              :default => false
  end

  add_index "sources", ["work_id"], :name => "index_sources_on_work_id"

  create_table "subscribes", :force => true do |t|
    t.string   "fullname"
    t.string   "departament"
    t.text     "position"
    t.string   "place"
    t.string   "phone_inter"
    t.string   "phone_city"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "substrates", :force => true do |t|
    t.string   "title"
    t.string   "drawing"
    t.string   "number"
    t.string   "state"
    t.integer  "user_id"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "theme"
    t.integer  "place"
    t.string   "category",   :null => false
  end

  add_index "substrates", ["user_id"], :name => "index_substrates_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "machine_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "complete",   :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "tasks", ["machine_id"], :name => "index_tasks_on_machine_id"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "teams", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "type_id"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "teams", ["type_id"], :name => "index_teams_on_type_id"

  create_table "tempusers", :force => true do |t|
    t.string   "username"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
    t.integer  "total_result", :default => 0
  end

  add_index "tempusers", ["user_id"], :name => "index_tempusers_on_user_id"

  create_table "types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "roles_mask"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "groups_mask",            :default => 1
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0,  :null => false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "works", :force => true do |t|
    t.text     "desc"
    t.integer  "art_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "works", ["art_id"], :name => "index_works_on_art_id"
  add_index "works", ["user_id"], :name => "index_works_on_user_id"

  create_table "years", :force => true do |t|
    t.string   "year"
    t.string   "slug",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "years", ["slug"], :name => "index_years_on_slug", :unique => true

end
