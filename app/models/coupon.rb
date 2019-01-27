class Coupon < ApplicationRecord
  validates :coupon, :active, presence: false
  validates :coupon, length: { minimum: 10, maximum: 10 }, allow_blank: true
end
