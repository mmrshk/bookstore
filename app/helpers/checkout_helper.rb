module CheckoutHelper
  def step_state(current_step)
    return 'active' if step_active?(current_step)
    'done' if step_done?(current_step)
  end

  def step_active?(current_step)
    current_step == step
  end

  def step_done?(current_step)
    past_step?(current_step)
  end

  def total_price_init(order)
    return order.total_price unless order.coupon

    order.total_price  - discount(order)
  end

  def discount(order)
    return 0 unless order.coupon

    order.total_price * order.coupon.sale / 100
  end
end
