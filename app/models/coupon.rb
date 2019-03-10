class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  validates :coupon, :active, presence: false
  validates :coupon, length: { is: 10 }, allow_blank: true

  scope :active, -> { where active: true }
end
