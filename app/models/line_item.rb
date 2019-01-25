class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :order, optional: true

  def total_price
    book.price * quantity.to_i
  end
end
