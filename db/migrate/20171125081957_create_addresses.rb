class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "administrative_area_level_1"
    t.string "locality"
    t.string "route"
    t.string "street_number"
    t.integer "postal_code"
    t.bigint "property_id"
    t.index ["property_id"], name: "index_addresses_on_property_id"

    t.timestamps
  end
  end
end
