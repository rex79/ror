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

ActiveRecord::Schema.define(:version => 20121001153131) do

  create_table "lingues", :force => true do |t|
    t.string   "cod"
    t.string   "lingua"
    t.integer  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "media", :force => true do |t|
    t.integer  "fkfile"
    t.integer  "fkmod"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mod_cat_smls", :force => true do |t|
    t.integer  "fkparent"
    t.string   "fklang"
    t.string   "title"
    t.text     "abstract"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "mod_cats", :force => true do |t|
    t.integer  "idserv"
    t.integer  "f_del"
    t.integer  "ordine"
    t.integer  "fkparent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "published"
  end

  create_table "mod_smls", :force => true do |t|
    t.integer  "fkparent"
    t.string   "fklang"
    t.string   "url_title"
    t.string   "title"
    t.text     "abstract"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "mods", :force => true do |t|
    t.integer  "idserv"
    t.integer  "fkcat"
    t.string   "home"
    t.integer  "f_del"
    t.integer  "ordine"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "published"
    t.string   "data_evento"
  end

  create_table "servizis", :force => true do |t|
    t.integer  "fkparent"
    t.string   "nome"
    t.string   "label"
    t.integer  "enabled"
    t.integer  "ordine"
    t.string   "path"
    t.integer  "skip_cat"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "static_page_smls", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "header"
    t.text     "testo"
    t.text     "footer"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "static_page_id"
    t.string   "fklang"
  end

  create_table "static_pages", :force => true do |t|
    t.integer  "f_del"
    t.integer  "published"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "foto"
    t.string   "foto_home"
    t.string   "url_pagina"
    t.integer  "home_page"
    t.integer  "ordine"
    t.string   "related_cat"
  end

  create_table "uploads", :force => true do |t|
    t.string   "fkfolder"
    t.string   "filename"
    t.string   "ext"
    t.string   "content_type"
    t.integer  "file_size"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "level"
    t.integer  "active"
  end

end
