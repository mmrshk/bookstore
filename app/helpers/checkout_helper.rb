module CheckoutHelper
  def subtotal_price_init
    set_order.total_price
  end

  def total_price_init
    return set_order.total_price unless set_order.coupon

    set_order.total_price  - discount
  end

  def discount
    return 0 unless set_order.coupon

    set_order.total_price * set_order.coupon.sale / 100
  end

  private

  def set_order
    Order.find_by(id: session[:order_id])
  end
end
