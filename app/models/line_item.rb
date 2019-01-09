class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  def total_price
    book.price.to_i * quantity.to_i
  end

  def increase!
    quantity += 1
  end

  def decrease!
    quantity -= 1 if quantity.positive?
  end
end
