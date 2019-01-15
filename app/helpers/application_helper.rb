module ApplicationHelper
  include Pagy::Frontend

  def cart_items_count
    return LineItem.where(id: session[:order_item_ids].sum(:quantity)) if session[:order_item_ids]

    current_order.line_items.sum(:quantity)
  end
end
