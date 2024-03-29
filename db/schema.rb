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

ActiveRecord::Schema[7.1].define(version: 2024_03_12_100211) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_accounts_on_code", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "asset_types", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_asset_types_on_lft"
    t.index ["parent_id"], name: "index_asset_types_on_parent_id"
    t.index ["rgt"], name: "index_asset_types_on_rgt"
  end

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "cost"
    t.datetime "date", precision: nil
    t.integer "status"
    t.string "inventory_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "code"
    t.datetime "start_date", precision: nil
    t.integer "useful_life"
    t.integer "count"
    t.bigint "account_id"
    t.bigint "organization_id"
    t.bigint "mol_id"
    t.bigint "type_id"
    t.boolean "delete_mark", default: false, null: false
    t.index ["account_id"], name: "index_assets_on_account_id"
    t.index ["code", "inventory_number"], name: "index_assets_on_code_and_inventory_number", unique: true
    t.index ["mol_id"], name: "index_assets_on_mol_id"
    t.index ["organization_id"], name: "index_assets_on_organization_id"
    t.index ["slug"], name: "index_assets_on_slug", unique: true
    t.index ["type_id"], name: "index_assets_on_type_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["lft"], name: "index_departments_on_lft"
    t.index ["organization_id"], name: "index_departments_on_organization_id"
    t.index ["parent_id"], name: "index_departments_on_parent_id"
    t.index ["rgt"], name: "index_departments_on_rgt"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code"
    t.bigint "title_id"
    t.bigint "organization_id"
    t.boolean "delete_mark", default: false, null: false
    t.index ["code"], name: "index_employees_on_code", unique: true
    t.index ["organization_id"], name: "index_employees_on_organization_id"
    t.index ["title_id"], name: "index_employees_on_title_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "job_histories", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.integer "action"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.jsonb "values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_histories_on_job_id"
    t.index ["record_type", "record_id"], name: "index_job_histories_on_record"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_id", null: false
    t.integer "job_type", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.jsonb "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "description"
    t.float "cost"
    t.string "code"
    t.integer "count"
    t.bigint "account_id"
    t.bigint "organization_id"
    t.bigint "mol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_id"
    t.boolean "delete_mark", default: false, null: false
    t.index ["account_id"], name: "index_materials_on_account_id"
    t.index ["code"], name: "index_materials_on_code", unique: true
    t.index ["mol_id"], name: "index_materials_on_mol_id"
    t.index ["organization_id"], name: "index_materials_on_organization_id"
    t.index ["slug"], name: "index_materials_on_slug", unique: true
    t.index ["type_id"], name: "index_materials_on_type_id"
  end

  create_table "mols", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_mols_on_code", unique: true
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "text", null: false
    t.json "details"
    t.string "noteble_type", null: false
    t.bigint "noteble_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["noteble_type", "noteble_id"], name: "index_notes_on_noteble"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_organizations_on_code", unique: true
  end

  create_table "possessions", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "employee_id"
    t.string "possessionable_type", null: false
    t.bigint "possessionable_id", null: false
    t.integer "count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_possessions_on_employee_id"
    t.index ["possessionable_type", "possessionable_id"], name: "index_possessions_on_possessionable"
    t.index ["room_id"], name: "index_possessions_on_room_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_rooms_on_location_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "titles", force: :cascade do |t|
    t.string "name"
    t.integer "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_titles_on_department_id"
    t.index ["organization_id"], name: "index_titles_on_organization_id"
  end

  create_table "uids", force: :cascade do |t|
    t.string "uid", null: false
    t.string "uidable_type", null: false
    t.bigint "uidable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_uids_on_uid", unique: true
    t.index ["uidable_type", "uidable_id"], name: "index_uids_on_uidable"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.integer "role", default: 0, null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false, null: false
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assets", "accounts"
  add_foreign_key "assets", "asset_types", column: "type_id"
  add_foreign_key "assets", "mols"
  add_foreign_key "assets", "organizations"
  add_foreign_key "departments", "organizations"
  add_foreign_key "employees", "organizations"
  add_foreign_key "employees", "titles"
  add_foreign_key "materials", "accounts"
  add_foreign_key "materials", "asset_types", column: "type_id"
  add_foreign_key "materials", "mols"
  add_foreign_key "materials", "organizations"
  add_foreign_key "possessions", "employees"
  add_foreign_key "possessions", "rooms"
  add_foreign_key "rooms", "locations"
  add_foreign_key "titles", "departments"
  add_foreign_key "titles", "organizations"
end
