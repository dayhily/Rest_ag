class Property < ApplicationRecord
	validates :country, presence: true
	validates :locality, presence: true
	validates :route, presence: true
	validates :street_number, presence: true
	validates :property_type, presence: true
	validates :area_size, numericality: {greater_than_or_equal_to: 0.01}
	validates :number_of_rooms, numericality: {greater_than_or_equal_to:1}
	validates :property_price, numericality: {greater_than_or_equal_to: 0.01}
end
