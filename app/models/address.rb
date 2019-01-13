class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :firstname, :lastname, :address, :city, :zip, :country, :phone, :cast, presence: true
  enum cast: [:shipping, :billing]
end
