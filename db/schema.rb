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

ActiveRecord::Schema[7.0].define(version: 2023_10_13_122138) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "air_quality_metrics", force: :cascade do |t|
    t.float "aqi"
    t.float "co"
    t.float "no"
    t.float "no2"
    t.float "o3"
    t.float "so2"
    t.float "pm2_5"
    t.float "pm10"
    t.float "nh3"
    t.float "dt"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_air_quality_metrics_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.text "lat"
    t.text "long"
    t.text "name"
    t.jsonb "api_response"
    t.jsonb "api_request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
