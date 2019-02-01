module UpdateCheckoutService
  class << self
    def update_confirm(current_order)
      current_order.update(status: Order::ORDER_FILTERS.keys.first.to_s)
      current_order.update(step: :complete)
      current_order.set_complete_date
      current_order.coupon.update(active: false) if current_order.coupon
    end

    def update_payment(current_order, credit_card)
      current_order.update(credit_card_id: credit_card.id)
      current_order.update(step: :confirm)
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
