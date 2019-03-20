class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  validates :code, :active, presence: false
  validates :code, uniqueness: true
  validates :code, length: { is: 10 }, allow_blank: true

  scope :active, -> { where active: true }
end
