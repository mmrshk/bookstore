class ShowCheckoutService
  attr_reader :user, :order

  def initialize(current_user, current_order)
    @user = current_user
    @order = current_order
  end

  def login(options = nil)
    options[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def addresses(options = nil)
    AddressesForm.new(show_addresses_params)
  end

  def delivery(options = nil)
    Delivery.all
  end

  def payment(options = nil)
    order.credit_card || user.credit_card || CreditCard.new
  end

  def confirm(options = nil); end

  def complete(options = nil)
    OrderMailer.confirm_order(user).deliver_now
    options[:order_complete] = false
    user.orders.in_queue.last
  end

  private

  def show_addresses_params
    return { order_id: order.id } if order.addresses.any?

    { user_id: user.id }
  end
end
