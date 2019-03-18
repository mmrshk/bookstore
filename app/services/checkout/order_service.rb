class Checkout::OrderService
  class << self
    def call(current_user, current_order)
      order = current_order.update(user_id: current_user.id)

      order
    end
  end
end
