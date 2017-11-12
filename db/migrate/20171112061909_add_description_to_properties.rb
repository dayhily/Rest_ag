class AddDescriptionToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :description, :string
  end
end
