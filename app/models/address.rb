class Address < ApplicationRecord
  belongs_to :property, inverse_of: :address
  validates :country, :locality, :route, :street_number, presence: true
end
