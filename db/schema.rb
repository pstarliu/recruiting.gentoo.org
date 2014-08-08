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

ActiveRecord::Schema.define(version: 20140704110756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "workflow_state"
    t.integer  "operator_id"
    t.datetime "deleted_at"
  end

  add_index "answers", ["deleted_at"], name: "index_answers_on_deleted_at", using: :btree
  add_index "answers", ["operator_id"], name: "index_answers_on_operator_id", using: :btree
  add_index "answers", ["user_id", "question_id"], name: "index_answers_on_user_id_and_question_id", using: :btree
  add_index "answers", ["workflow_state"], name: "index_answers_on_workflow_state", using: :btree

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "groups", ["deleted_at"], name: "index_groups_on_deleted_at", using: :btree

  create_table "mentorships", id: false, force: true do |t|
    t.integer "mentor_id"
    t.integer "candidate_id"
  end

  add_index "mentorships", ["candidate_id", "mentor_id"], name: "index_mentorships_on_candidate_id_and_mentor_id", using: :btree
  add_index "mentorships", ["mentor_id", "candidate_id"], name: "index_mentorships_on_mentor_id_and_candidate_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.datetime "deleted_at"
  end

  add_index "questions", ["deleted_at"], name: "index_questions_on_deleted_at", using: :btree
  add_index "questions", ["group_id"], name: "index_questions_on_group_id", using: :btree

  create_table "ready_users", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.boolean "recruited", default: false
  end

  add_index "ready_users", ["user_id", "group_id"], name: "index_ready_users_on_user_id_and_group_id", unique: true, using: :btree

  create_table "user_groups", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "workflow_state"
    t.text     "biography"
    t.integer  "mentor_id"
    t.text     "ssh_key"
    t.string   "address"
    t.string   "skills"
    t.string   "other_skills"
    t.string   "projects"
    t.date     "date_of_birth"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "gpg_key"
    t.datetime "deleted_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["workflow_state"], name: "index_users_on_workflow_state", using: :btree

end
