# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_20_081643) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "status", ["pending", "active", "deactivated"]

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.enum "status", default: "pending", null: false, enum_type: "status"
    t.datetime "deactivated_at"
    t.bigint "deactivated_by_id"
    t.datetime "reactivated_at"
    t.bigint "reactivated_by_id"
    t.string "otp_secret"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login", default: false
    t.index ["deactivated_by_id"], name: "index_admin_users_on_deactivated_by_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_admin_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_admin_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_admin_users_on_invited_by"
    t.index ["name"], name: "index_admin_users_on_name", unique: true
    t.index ["reactivated_by_id"], name: "index_admin_users_on_reactivated_by_id"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "announcements", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "message", limit: 255
    t.datetime "expires_at", precision: nil, null: false
    t.bigint "user_id"
    t.string "learn_more_url"
    t.index ["expires_at"], name: "index_announcements_on_expires_at"
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

  create_table "contents", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_contents_on_lesson_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "position", null: false
    t.string "slug"
    t.string "identifier_uuid", default: "", null: false
    t.integer "path_id"
    t.boolean "show_on_homepage", default: false, null: false
    t.string "badge_uri", null: false
    t.integer "lessons_count", default: 0, null: false
    t.integer "projects_count", default: 0, null: false
    t.index ["identifier_uuid"], name: "index_courses_on_identifier_uuid", unique: true
    t.index ["path_id"], name: "index_courses_on_path_id"
    t.index ["slug"], name: "index_courses_on_slug"
  end

  create_table "flags", force: :cascade do |t|
    t.integer "flagger_id", null: false
    t.bigint "project_submission_id", null: false
    t.text "extra", default: ""
    t.integer "status", default: 0, null: false
    t.integer "taken_action", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "resolved_by_id"
    t.integer "reason", default: 4, null: false
    t.index ["flagger_id"], name: "index_flags_on_flagger_id"
    t.index ["project_submission_id"], name: "index_flags_on_project_submission_id"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "lesson_completions", id: :serial, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "lesson_identifier_uuid", default: "", null: false
    t.integer "course_id"
    t.integer "path_id"
    t.index ["course_id"], name: "index_lesson_completions_on_course_id"
    t.index ["lesson_id", "user_id"], name: "index_lesson_completions_on_lesson_id_and_user_id", unique: true
    t.index ["lesson_identifier_uuid"], name: "index_lesson_completions_on_lesson_identifier_uuid"
    t.index ["path_id"], name: "index_lesson_completions_on_path_id"
    t.index ["user_id"], name: "index_lesson_completions_on_user_id"
  end

  create_table "lesson_previews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "github_path", limit: 255
    t.integer "position", null: false
    t.text "description"
    t.boolean "is_project", default: false
    t.integer "section_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug"
    t.boolean "accepts_submission", default: false, null: false
    t.boolean "previewable", default: false, null: false
    t.boolean "choose_path_lesson", default: false, null: false
    t.string "identifier_uuid", default: "", null: false
    t.bigint "course_id"
    t.boolean "installation_lesson", default: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["github_path"], name: "index_lessons_on_github_path"
    t.index ["identifier_uuid", "course_id"], name: "index_lessons_on_identifier_uuid_and_course_id", unique: true
    t.index ["installation_lesson"], name: "index_lessons_on_installation_lesson"
    t.index ["position"], name: "index_lessons_on_position"
    t.index ["slug", "section_id"], name: "index_lessons_on_slug_and_section_id", unique: true
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.string "likeable_type", null: false
    t.integer "likeable_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type"
    t.index ["user_id", "likeable_id", "likeable_type"], name: "index_likes_on_user_id_and_likeable_id_and_likeable_type", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.text "message", null: false
    t.string "title", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "path_prerequisites", force: :cascade do |t|
    t.bigint "path_id", null: false
    t.bigint "prerequisite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path_id", "prerequisite_id"], name: "index_path_prerequisites_on_path_id_and_prerequisite_id", unique: true
    t.index ["path_id"], name: "index_path_prerequisites_on_path_id"
    t.index ["prerequisite_id"], name: "index_path_prerequisites_on_prerequisite_id"
  end

  create_table "paths", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "position"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug"
    t.boolean "default_path", default: false, null: false
    t.string "identifier_uuid", default: "", null: false
    t.string "short_title"
    t.string "badge_uri", null: false
    t.integer "users_count", default: 0
    t.index ["identifier_uuid"], name: "index_paths_on_identifier_uuid", unique: true
    t.index ["slug"], name: "index_paths_on_slug", unique: true
  end

  create_table "points", force: :cascade do |t|
    t.string "discord_id", null: false
    t.integer "points", default: 0, null: false
    t.index ["discord_id"], name: "index_points_on_discord_id", unique: true
  end

  create_table "project_submissions", id: :serial, force: :cascade do |t|
    t.string "repo_url"
    t.string "live_preview_url", default: "", null: false
    t.integer "user_id"
    t.integer "lesson_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_public", default: true, null: false
    t.integer "likes_count", default: 0
    t.datetime "discarded_at", precision: nil
    t.datetime "discard_at", precision: nil
    t.index ["created_at"], name: "index_project_submissions_on_created_at"
    t.index ["discarded_at"], name: "index_project_submissions_on_discarded_at"
    t.index ["is_public"], name: "index_project_submissions_on_is_public"
    t.index ["lesson_id"], name: "index_project_submissions_on_lesson_id"
    t.index ["likes_count"], name: "index_project_submissions_on_likes_count"
    t.index ["user_id", "lesson_id"], name: "index_project_submissions_on_user_id_and_lesson_id", unique: true, where: "(discarded_at IS NULL)"
    t.index ["user_id"], name: "index_project_submissions_on_user_id"
  end

  create_table "sections", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "position", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "description"
    t.string "identifier_uuid", default: "", null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
    t.index ["identifier_uuid"], name: "index_sections_on_identifier_uuid", unique: true
    t.index ["position"], name: "index_sections_on_position"
  end

  create_table "success_stories", id: :serial, force: :cascade do |t|
    t.string "student_name"
    t.string "avatar_path_name"
    t.text "story_content"
    t.string "job_title"
    t.string "social_media_link"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "user_providers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_user_providers_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "username", limit: 255
    t.text "learning_goal"
    t.boolean "admin", default: false, null: false
    t.string "avatar"
    t.integer "path_id", default: 1
    t.boolean "banned", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "admin_users", "admin_users", column: "deactivated_by_id"
  add_foreign_key "admin_users", "admin_users", column: "reactivated_by_id"
  add_foreign_key "announcements", "users"
  add_foreign_key "contents", "lessons"
  add_foreign_key "flags", "project_submissions"
  add_foreign_key "flags", "users", column: "flagger_id"
  add_foreign_key "lesson_completions", "lessons", on_delete: :cascade
  add_foreign_key "lessons", "courses"
  add_foreign_key "likes", "users"
  add_foreign_key "path_prerequisites", "paths"
  add_foreign_key "path_prerequisites", "paths", column: "prerequisite_id"
  add_foreign_key "project_submissions", "lessons"
  add_foreign_key "project_submissions", "users"

  create_view "all_lesson_completions_day_stats", materialized: true, sql_definition: <<-SQL
      SELECT row_number() OVER (ORDER BY ((lesson_completions.created_at)::date)) AS id,
      (lesson_completions.created_at)::date AS date,
      count(*) AS completions_count
     FROM lesson_completions
    GROUP BY ((lesson_completions.created_at)::date)
    ORDER BY ((lesson_completions.created_at)::date);
  SQL
  create_view "path_lesson_completions_day_stats", materialized: true, sql_definition: <<-SQL
      SELECT row_number() OVER (ORDER BY ((lesson_completions.created_at)::date) DESC) AS id,
      lesson_completions.path_id,
      lesson_completions.lesson_id,
      lesson_completions.course_id,
      lessons."position" AS lesson_position,
      courses."position" AS course_position,
      (lesson_completions.created_at)::date AS date,
      lessons.title AS lesson_title,
      count(*) AS completions_count
     FROM ((lesson_completions
       JOIN lessons ON ((lesson_completions.lesson_id = lessons.id)))
       JOIN courses ON ((lesson_completions.course_id = courses.id)))
    GROUP BY ((lesson_completions.created_at)::date), lesson_completions.path_id, lesson_completions.lesson_id, lessons.title, lesson_completions.course_id, lessons."position", courses."position"
    ORDER BY ((lesson_completions.created_at)::date) DESC;
  SQL
  create_view "user_sign_ups_day_stats", materialized: true, sql_definition: <<-SQL
      SELECT row_number() OVER (ORDER BY ((users.created_at)::date)) AS id,
      (users.created_at)::date AS date,
      count(*) AS sign_ups_count
     FROM users
    GROUP BY ((users.created_at)::date)
    ORDER BY ((users.created_at)::date);
  SQL
end
