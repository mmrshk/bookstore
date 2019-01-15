class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :credit_card, optional: true

  has_many :line_items, dependent: :destroy
  has_many :addresses, as: :addressable

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
