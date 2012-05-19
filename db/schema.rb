# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(:version => 20120517140621) do

  create_table "usuarios", :force => true do |t|
    t.string   "nome"
    t.string   "usuario"
    t.string   "email"
    t.string   "password_digest"
    t.string   "password_reset"
    t.datetime "ultimo_acesso"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
