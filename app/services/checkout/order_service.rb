class Checkout::OrderService
  class << self
    def call(current_user, current_order)
      current_order.update(user_id: current_user.id)

      current_order
    end
  end
end
