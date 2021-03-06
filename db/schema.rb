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

ActiveRecord::Schema.define(version: 20_180_102_072_256) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'country'
    t.string 'administrative_area_level_1'
    t.string 'locality'
    t.string 'route'
    t.string 'street_number'
    t.integer 'postal_code'
    t.bigint 'property_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['property_id'], name: 'index_addresses_on_property_id'
  end

  create_table 'contacts', force: :cascade do |t|
    t.string 'email'
    t.text 'message'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'properties', force: :cascade do |t|
    t.string 'property_type'
    t.integer 'number_of_rooms'
    t.integer 'area_size'
    t.integer 'property_price'
    t.string 'images', default: [], array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'description'
    t.integer 'user_id'
    t.index ['images'], name: 'index_properties_on_images'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'username'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['username'], name: 'index_users_on_username', unique: true
  end
end
