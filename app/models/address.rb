class Address < ApplicationRecord
	belongs_to :property, inverse_of: :address
end
