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

ActiveRecord::Schema[7.1].define(version: 2023_12_01_183151) do
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
    t.bigint "location_id"
    t.integer "count"
    t.bigint "account_id"
    t.bigint "organization_id"
    t.bigint "mol_id"
    t.index ["account_id"], name: "index_assets_on_account_id"
    t.index ["code", "inventory_number"], name: "index_assets_on_code_and_inventory_number", unique: true
    t.index ["location_id"], name: "index_assets_on_location_id"
    t.index ["mol_id"], name: "index_assets_on_mol_id"
    t.index ["organization_id"], name: "index_assets_on_organization_id"
    t.index ["slug"], name: "index_assets_on_slug", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code"
    t.index ["code"], name: "index_employees_on_code", unique: true
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

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.index ["lft"], name: "index_locations_on_lft"
    t.index ["parent_id"], name: "index_locations_on_parent_id"
    t.index ["rgt"], name: "index_locations_on_rgt"
  end

  create_table "materials", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "description"
    t.float "cost"
    t.string "code"
    t.integer "count"
    t.bigint "location_id"
    t.bigint "account_id"
    t.bigint "organization_id"
    t.bigint "mol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_materials_on_account_id"
    t.index ["code"], name: "index_materials_on_code", unique: true
    t.index ["location_id"], name: "index_materials_on_location_id"
    t.index ["mol_id"], name: "index_materials_on_mol_id"
    t.index ["organization_id"], name: "index_materials_on_organization_id"
    t.index ["slug"], name: "index_materials_on_slug", unique: true
  end

  create_table "mols", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_mols_on_code", unique: true
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "date", default: "2023-11-30 06:04:04"
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

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assets", "accounts"
  add_foreign_key "assets", "locations"
  add_foreign_key "assets", "mols"
  add_foreign_key "assets", "organizations"
  add_foreign_key "materials", "accounts"
  add_foreign_key "materials", "locations"
  add_foreign_key "materials", "mols"
  add_foreign_key "materials", "organizations"
end
