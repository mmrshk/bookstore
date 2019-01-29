class Coupon < ApplicationRecord
  validates :coupon, :active, presence: false
  validates :coupon, length: { is: 10 }, allow_blank: true
end
