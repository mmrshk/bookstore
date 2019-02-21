module UpdateCheckoutService
  class << self
    def update_confirm(current_order)
      current_order.update(status: Order::ORDER_FILTERS.keys.first.to_s, completed_at: Time.current, step: :complete)
      current_order.coupon.update(active: false) if current_order.coupon
    end

    def update_payment(current_order, credit_card)
      current_order.update(credit_card_id: credit_card.id, step: :confirm)
    end

    def update_delivery(current_order, order_params)
      current_order.update(order_params)
      current_order.update(step: :payment)
    end

    def update_addresses(current_order)
      current_order.update(step: :delivery)
    end
  end
end
