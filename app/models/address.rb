class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true
  validates :firstname, :lastname, :address, :city, :zip, :country, :phone, :cast, presence: true

  enum cast: %i[shipping billing]

  scope :shipping, -> { where(cast: 0) }
  scope :billing,  -> { where(cast: 1) }
end
