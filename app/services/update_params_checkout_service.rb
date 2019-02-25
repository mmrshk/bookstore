module UpdateParamsCheckoutService
  class << self
    def update_confirm(current_order, session)
      current_order.update(status: OrderFilterService::ORDER_FILTERS.keys.first.to_s, completed_at: Time.current, step: :complete)
      current_order.coupon.update(active: false) if current_order.coupon
      session[:order_complete] = true
      session[:order_id] = nil
      session[:line_item_ids] = nil
      session[:coupon_id] = nil
    end

    def update_payment(current_order, credit_card)
      current_order.update(credit_card_id: credit_card.id, step: :confirm)
    end

    def update_delivery(current_order, order_params)
      current_order.update(delivery_id: order_params[:delivery_id], step: :payment)
    end

    def update_addresses(current_order)
      current_order.update(step: :delivery)
    end
  end
end
