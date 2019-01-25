module OrderHelper
  def order_status(order)
    Order::ORDER_FILTERS[order.status.to_sym]
  end
end
