class Property < ApplicationRecord
	has_one :address, inverse_of: :property
	accepts_nested_attributes_for :address, :allow_destroy => true
	#validates_presence_of :country, :locality, :route, :street_number
	#validates :property_type, presence: true
	#validates :area_size, numericality: {greater_than_or_equal_to: 0.01}
	#validates :number_of_rooms, presence: true
	#validates :property_price, numericality: {greater_than_or_equal_to: 0.01}
	#validates :images, presence: true
	#validate :number_of_image
	mount_uploaders :images, ImagesUploader
	paginates_per 5
end

private
  def number_of_image
    if images.size.to_i > 4
    errors.add(:images, I18n.t('errors.messages.number_of_image'))
    end
  end