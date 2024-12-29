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

ActiveRecord::Schema[8.0].define(version: 2024_12_28_114659) do
  create_table "authentications", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_stacks", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generals", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "user_id", limit: 36, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_01783649f8"
  end

  create_table "histories", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "general_id", limit: 36, null: false
    t.string "position_id", limit: 36, null: false
    t.string "scale_id", limit: 36, null: false
    t.string "core_stack_id", limit: 36, null: false
    t.string "infrastructure_id", limit: 36, null: false
    t.datetime "period"
    t.string "company_name", null: false
    t.string "project_name"
    t.string "contents"
    t.string "others"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["core_stack_id"], name: "fk_rails_38013b1888"
    t.index ["general_id"], name: "fk_rails_6f404c5489"
    t.index ["infrastructure_id"], name: "fk_rails_4f0c5111ca"
    t.index ["position_id"], name: "fk_rails_2da0cb21ab"
    t.index ["scale_id"], name: "fk_rails_c1b0c98510"
  end

  create_table "infrastructures", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scales", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "people", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "authentication_id", limit: 36, null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_id"], name: "fk_rails_cdb7968a37"
  end

  create_table "users", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "authentication_id", limit: 36, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_id"], name: "fk_rails_18163b8b94"
  end

  add_foreign_key "generals", "users"
  add_foreign_key "histories", "core_stacks"
  add_foreign_key "histories", "generals"
  add_foreign_key "histories", "infrastructures"
  add_foreign_key "histories", "positions"
  add_foreign_key "histories", "scales"
  add_foreign_key "sessions", "authentications"
  add_foreign_key "users", "authentications"
end
