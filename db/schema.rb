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

ActiveRecord::Schema.define(version: 2024_09_04_023136) do

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.string "author", limit: 50, null: false
    t.string "language", limit: 50, null: false
    t.boolean "availability", default: true
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_books_on_book_id", unique: true
  end

  create_table "borrowed_books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "book_id"
    t.datetime "issue_date", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "due_date"
    t.boolean "is_returned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrowed_books_on_book_id"
    t.index ["member_id"], name: "index_borrowed_books_on_member_id"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "email", null: false
    t.bigint "phone_number"
    t.boolean "active", default: true
    t.integer "member_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["member_id"], name: "index_members_on_member_id", unique: true
  end

  add_foreign_key "borrowed_books", "books"
  add_foreign_key "borrowed_books", "members"
end
