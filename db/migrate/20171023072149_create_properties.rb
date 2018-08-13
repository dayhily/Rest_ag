class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table 'properties', force: :cascade do |t|
      t.string 'property_type'
      t.string 'property_address'
      t.integer 'number_of_rooms'
      t.integer 'area_size'
      t.integer 'property_price'
      t.string 'images', default: [], array: true
      t.index ['images'], name: 'index_properties_on_images'

      t.timestamps
    end
  end
end
