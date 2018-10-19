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

ActiveRecord::Schema.define(version: 2016_04_01_000800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.integer "index", default: 0
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "index"], name: "index_active_storage_attachments_sorting"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.boolean "published", default: false
    t.boolean "navigated", default: false
    t.string "name", null: false
    t.string "header"
    t.text "content"
    t.boolean "partial", default: false
    t.string "title"
    t.string "keywords"
    t.string "description"
    t.string "canonical"
    t.string "robots"
    t.integer "index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.index ["ancestry"], name: "index_activities_on_ancestry"
    t.index ["index"], name: "index_activities_on_index"
    t.index ["name"], name: "index_activities_on_name", unique: true
    t.index ["navigated"], name: "index_activities_on_navigated"
    t.index ["published"], name: "index_activities_on_published"
  end

  create_table "areas", force: :cascade do |t|
    t.boolean "active", default: false
    t.string "name", null: false
    t.integer "index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_areas_on_active"
    t.index ["index"], name: "index_areas_on_index"
    t.index ["name"], name: "index_areas_on_name", unique: true
  end

  create_table "areas_throughs", force: :cascade do |t|
    t.string "resource_type"
    t.bigint "resource_id"
    t.bigint "area_id"
    t.index ["area_id"], name: "index_areas_throughs_on_area_id"
    t.index ["resource_type", "resource_id", "area_id"], name: "index_areas_throughs_for_uniqueness", unique: true
    t.index ["resource_type", "resource_id"], name: "index_areas_throughs_on_resource_type_and_resource_id"
  end

  create_table "articles", force: :cascade do |t|
    t.boolean "published", default: false
    t.boolean "navigated", default: false
    t.date "published_at"
    t.string "header", null: false
    t.text "annotation"
    t.text "content"
    t.boolean "partial", default: false
    t.string "upload"
    t.boolean "upload_crop", default: true
    t.string "title"
    t.string "keywords"
    t.string "description"
    t.string "canonical"
    t.string "robots"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["header"], name: "index_articles_on_header"
    t.index ["navigated"], name: "index_articles_on_navigated"
    t.index ["published"], name: "index_articles_on_published"
    t.index ["published_at", "header"], name: "index_articles_on_published_at_and_header", unique: true
    t.index ["published_at"], name: "index_articles_on_published_at"
  end

  create_table "customers", force: :cascade do |t|
    t.boolean "active", default: false
    t.boolean "published", default: false
    t.boolean "navigated", default: false
    t.string "name", null: false
    t.text "content"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "geo"
    t.string "website"
    t.string "upload"
    t.string "title"
    t.string "keywords"
    t.string "description"
    t.string "canonical"
    t.string "robots"
    t.integer "index", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_customers_on_active"
    t.index ["index"], name: "index_customers_on_index"
    t.index ["name"], name: "index_customers_on_name", unique: true
    t.index ["navigated"], name: "index_customers_on_navigated"
    t.index ["published"], name: "index_customers_on_published"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.boolean "published", default: false
    t.boolean "navigated", default: false
    t.date "published_at"
    t.string "header", null: false
    t.text "content"
    t.string "upload"
    t.string "title"
    t.string "keywords"
    t.string "description"
    t.string "canonical"
    t.string "robots"
    t.string "source"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_feedbacks_on_customer_id"
    t.index ["header"], name: "index_feedbacks_on_header"
    t.index ["navigated"], name: "index_feedbacks_on_navigated"
    t.index ["published"], name: "index_feedbacks_on_published"
    t.index ["published_at"], name: "index_feedbacks_on_published_at"
  end

  create_table "images", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "alt"
    t.string "upload", null: false
    t.boolean "upload_crop", default: false
    t.integer "index", default: 0
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index"], name: "index_images_on_index"
    t.index ["resource_type", "resource_id"], name: "index_images_on_resource_type_and_resource_id"
  end

  create_table "permits", force: :cascade do |t|
    t.boolean "published", default: false
    t.boolean "navigated", default: false
    t.string "name", null: false
    t.string "header"
    t.string "number", null: false
    t.string "provider", null: false
    t.date "issue_at", null: false
    t.date "onset_at"
    t.date "end_at"
    t.string "title"
    t.string "keywords"
    t.string "description"
    t.string "canonical"
    t.string "robots"
    t.integer "index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index"], name: "index_permits_on_index"
    t.index ["issue_at"], name: "index_permits_on_issue_at"
    t.index ["name"], name: "index_permits_on_name"
    t.index ["navigated"], name: "index_permits_on_navigated"
    t.index ["number"], name: "index_permits_on_number", unique: true
    t.index ["provider"], name: "index_permits_on_provider"
    t.index ["published"], name: "index_permits_on_published"
  end

  create_table "targets", force: :cascade do |t|
    t.boolean "published", default: false
    t.boolean "navigated", default: false
    t.integer "importance", default: 0
    t.date "start_at"
    t.date "finish_at"
    t.string "name", null: false
    t.string "header"
    t.text "content"
    t.string "address"
    t.string "geo"
    t.string "website"
    t.string "title"
    t.string "keywords"
    t.string "description"
    t.string "canonical"
    t.string "robots"
    t.integer "index", default: 0
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_targets_on_customer_id"
    t.index ["importance"], name: "index_targets_on_importance"
    t.index ["index"], name: "index_targets_on_index"
    t.index ["name"], name: "index_targets_on_name", unique: true
    t.index ["navigated"], name: "index_targets_on_navigated"
    t.index ["published"], name: "index_targets_on_published"
    t.index ["start_at"], name: "index_targets_on_start_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.boolean "in_staff", default: false
    t.string "name"
    t.string "phone"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["is_admin", "in_staff"], name: "index_users_on_is_admin_and_in_staff"
  end

  add_foreign_key "areas_throughs", "areas", on_delete: :cascade
  add_foreign_key "customers", "users", on_delete: :nullify
  add_foreign_key "feedbacks", "customers", on_delete: :nullify
  add_foreign_key "targets", "customers", on_delete: :nullify
end
