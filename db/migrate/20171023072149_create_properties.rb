class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :property_type
      t.string :property_address
      t.integer :number_of_rooms
      t.integer :area_size
      t.integer :property_price

      t.timestamps
    end
  end
end
