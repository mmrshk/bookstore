class Checkout::OrderService
  class << self
    def call(session, current_user)
      order = current_user.orders.new(line_item_ids: session[:line_item_ids], coupon_id: session[:coupon_id])
      order if order.save
    end
  end
end
