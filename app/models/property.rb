class Property < ApplicationRecord
  belongs_to :user
  has_one :address, inverse_of: :property, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  validates :user_id, presence: true
  validates :property_type, presence: true
  validates :area_size, numericality: { greater_than_or_equal_to: 0.01 }
  validates :number_of_rooms, presence: true
  validates :property_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :images, presence: true
  validate :number_of_image
  mount_uploaders :images, ImagesUploader
  paginates_per 10
end

private
# Limitation for :number_of_image
def number_of_image
  errors.add(:images, I18n.t('errors.messages.number_of_image')) if images.size.to_i > 6
end
