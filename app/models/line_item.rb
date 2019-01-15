class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :order, optional: true

  def total_price
    book.price * quantity.to_i
  end

  def increase!
    increment(quantity)
  end

  def decrease!
    decrement(quantity) if quantity.positive?
  end
end
