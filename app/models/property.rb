class Property < ApplicationRecord
	validates_presence_of :country, :locality, :route, :street_number
	validates :property_type, presence: true
	validates :area_size, numericality: {greater_than_or_equal_to: 0.01}
	validates :number_of_rooms, presence: true
	validates :property_price, numericality: {greater_than_or_equal_to: 0.01}
end
