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

ActiveRecord::Schema.define(version: 2021_04_05_114706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "banks", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.string "country"
    t.integer "bp_bank_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bp_bank_id"], name: "index_banks_on_bp_bank_id", unique: true
    t.index ["name"], name: "index_banks_on_name", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "bank_id", null: false
    t.bigint "request_id", null: false
    t.jsonb "meta"
    t.datetime "data_added"
    t.string "file_size"
    t.string "file_url"
    t.string "file_ext"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_documents_on_bank_id"
    t.index ["request_id"], name: "index_documents_on_request_id"
  end

  create_table "fees", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.string "search_name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_fees_on_product_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "fee_id", null: false
    t.bigint "subproduct_id", null: false
    t.bigint "document_id", null: false
    t.string "name"
    t.float "amount"
    t.string "category"
    t.string "tax"
    t.float "tax_amount"
    t.string "tax_category"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_prices_on_document_id"
    t.index ["fee_id"], name: "index_prices_on_fee_id"
    t.index ["subproduct_id"], name: "index_prices_on_subproduct_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "search_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requests", force: :cascade do |t|
    t.jsonb "content"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subproducts", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "bank_id", null: false
    t.string "name"
    t.string "search_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_subproducts_on_bank_id"
    t.index ["product_id"], name: "index_subproducts_on_product_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.string "name"
    t.bigint "bank_id"
    t.index ["bank_id"], name: "index_users_on_bank_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "websites", force: :cascade do |t|
    t.string "url"
    t.string "description"
    t.bigint "bank_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_websites_on_bank_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "documents", "banks"
  add_foreign_key "documents", "requests"
  add_foreign_key "fees", "products"
  add_foreign_key "prices", "documents"
  add_foreign_key "prices", "fees"
  add_foreign_key "prices", "subproducts"
  add_foreign_key "subproducts", "banks"
  add_foreign_key "subproducts", "products"
  add_foreign_key "users", "banks"
  add_foreign_key "websites", "banks"
end
