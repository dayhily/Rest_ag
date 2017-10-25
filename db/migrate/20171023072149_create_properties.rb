class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string "country"
      t.string "administrative_area_level_1"
      t.string "locality"
      t.string "route"
      t.string "street_number"
      t.integer "postal_code"
      t.string :property_type
      t.string :property_address
      t.integer :number_of_rooms
      t.integer :area_size
      t.integer :property_price

      t.timestamps
    end
  end
end
