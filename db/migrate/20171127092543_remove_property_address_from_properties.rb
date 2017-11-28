class RemovePropertyAddressFromProperties < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :property_address
  end
end
