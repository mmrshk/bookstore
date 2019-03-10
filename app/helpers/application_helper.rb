module ApplicationHelper
  include Pagy::Frontend

  def cart_items_count
    return session[:line_item_ids].length if session[:line_item_ids]

    current_order.line_items.sum(:quantity)
  end

  def number_to_euro(amount)
    number_to_currency(amount, unit: '€')
  end
end
