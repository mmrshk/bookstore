class Coupon < ApplicationRecord
  validates :coupon, :active, presence: true
  validates :coupon, length: {minimum: 10, maximum: 10}, allow_blank: true
end
