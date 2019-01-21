module ApplicationHelper
  include Pagy::Frontend

  def cart_items_count
    return LineItem.where(id: session[:line_item_ids]).count if session[:line_item_ids]

    current_order.line_items.sum(:quantity)
  end
end
