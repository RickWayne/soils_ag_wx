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

ActiveRecord::Schema.define(version: 20131120172150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awon_field_descrips", force: true do |t|
    t.integer  "rec_id"
    t.integer  "column_num"
    t.string   "field_name"
    t.string   "field_abbrev"
    t.string   "units"
    t.integer  "decimals"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "awon_record_types", force: true do |t|
    t.integer  "rec_id"
    t.string   "rec_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "awon_stations", force: true do |t|
    t.integer  "stnid"
    t.string   "name"
    t.string   "abbrev"
    t.string   "county"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "status"
    t.boolean  "wind"
    t.boolean  "humidity"
    t.boolean  "has_401"
    t.boolean  "has_403"
    t.boolean  "has_411"
    t.boolean  "has_412"
    t.boolean  "has_404"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.date     "date"
    t.text     "content"
    t.string   "tags",       array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "data_table_name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "subscribable"
    t.integer  "default_doy_start"
    t.integer  "default_doy_end"
  end

  create_table "spatial_ref_sys", id: false, force: true do |t|
    t.integer "srid",                   null: false
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "subscribers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "name"
    t.integer  "subscriber_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doy_start"
    t.integer  "doy_end"
    t.boolean  "enabled",       default: true
  end

  create_table "t401s", force: true do |t|
    t.integer  "awon_station_id"
    t.date     "date"
    t.integer  "time"
    t.float    "M5Pcpn"
    t.float    "M5Pcpn2"
    t.float    "M5Wind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t403s", force: true do |t|
    t.integer  "awon_station_id"
    t.date     "date"
    t.integer  "time"
    t.float    "HToPcpn"
    t.float    "HAvSol"
    t.float    "HAvTAir"
    t.float    "HAvRHum"
    t.float    "HAvTS05"
    t.float    "HAvTS10"
    t.float    "HAvTS50"
    t.float    "HPkWind"
    t.float    "HAvWind"
    t.float    "HRsWind"
    t.float    "HRsDir"
    t.float    "HDvDir"
    t.float    "HAvPAR"
    t.float    "HMxWnd1"
    t.float    "HAvTDew"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t406s", force: true do |t|
    t.integer  "awon_station_id"
    t.date     "date"
    t.integer  "time"
    t.float    "HhToPcpn"
    t.float    "HhAvSol"
    t.float    "HhAvTAir"
    t.float    "HhAvRHum"
    t.float    "HhAvTS05"
    t.float    "HhAvTS10"
    t.float    "HhAvTS50"
    t.float    "HhPkWind"
    t.float    "HhAvWind"
    t.float    "HhRsWind"
    t.float    "HhRsDir"
    t.float    "HhDvDir"
    t.float    "HhAvPAR"
    t.float    "HhMxWnd1"
    t.float    "HhAvTDew"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t411s", force: true do |t|
    t.integer  "awon_station_id"
    t.date     "date"
    t.integer  "time"
    t.float    "DMnBatt"
    t.float    "DToPcpn"
    t.float    "DAvSol"
    t.float    "DAvTAir"
    t.float    "DMxTAir"
    t.float    "DTxTAir"
    t.float    "DMnTAir"
    t.float    "DTnTAir"
    t.float    "DAvRHum"
    t.float    "DMxRHum"
    t.float    "DTxRHum"
    t.float    "DMnRHum"
    t.float    "DTnRHum"
    t.float    "DAvVPre"
    t.float    "DAvVDef"
    t.float    "DPkWind"
    t.float    "DTkWind"
    t.float    "DAvWind"
    t.float    "DRsWind"
    t.float    "DRsDir"
    t.float    "DDvDir"
    t.float    "DAvPAR"
    t.float    "DMxWnd1"
    t.float    "DTxWnd1"
    t.float    "DMxDir1"
    t.float    "DAvTdew"
    t.float    "DMxTdew"
    t.float    "DTxTdew"
    t.float    "DMnTdew"
    t.float    "DTnTdew"
    t.float    "DRefET"
    t.float    "DPctClr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t412s", force: true do |t|
    t.integer  "awon_station_id"
    t.date     "date"
    t.integer  "time"
    t.float    "DAvTS05"
    t.float    "DMxTS05"
    t.float    "DTxTS05"
    t.float    "DMnTS05"
    t.float    "DTnTS05"
    t.float    "DAvTS10"
    t.float    "DMxTS10"
    t.float    "DTxTS10"
    t.float    "DMnTS10"
    t.float    "DTnTS10"
    t.float    "DAvTS50"
    t.float    "DMxTS50"
    t.float    "DTxTS50"
    t.float    "DMnTS50"
    t.float    "DTnTS50"
    t.float    "DAvTS1m"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wi_mn_dets", force: true do |t|
    t.date     "dateStamp"
    t.time     "timeStamp"
    t.float    "latitude"
    t.float    "w980"
    t.float    "w976"
    t.float    "w972"
    t.float    "w968"
    t.float    "w964"
    t.float    "w960"
    t.float    "w956"
    t.float    "w952"
    t.float    "w948"
    t.float    "w944"
    t.float    "w940"
    t.float    "w936"
    t.float    "w932"
    t.float    "w928"
    t.float    "w924"
    t.float    "w920"
    t.float    "w916"
    t.float    "w912"
    t.float    "w908"
    t.float    "w904"
    t.float    "w900"
    t.float    "w896"
    t.float    "w892"
    t.float    "w888"
    t.float    "w884"
    t.float    "w880"
    t.float    "w876"
    t.float    "w872"
    t.float    "w868"
    t.float    "w864"
    t.float    "w860"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
