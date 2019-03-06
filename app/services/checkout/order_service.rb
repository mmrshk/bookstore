class Checkout::OrderService
  class << self
    def call(session, current_user)
      order = Order.new(line_item_ids: session[:line_item_ids], coupon_id: session[:coupon_id], user_id: current_user.id)
      return order if order.save
    end
  end
end
