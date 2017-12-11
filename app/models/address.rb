class Address < ApplicationRecord
	belongs_to :property, inverse_of: :address
	validates_presence_of :country, :locality, :route, :street_number
end
