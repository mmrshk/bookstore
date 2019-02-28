class ShowCheckoutService
  attr_reader :user, :order, :params
  attr_accessor :addresses, :deliveries, :credit_card, :order

  def initialize(current_user, current_order, step)
    @user = current_user
    @order = current_order
    @step = step
  end

  def call
    public_send(@step)
  end

  def addresses
    @addresses = AddressesForm.new(order)
  end

  def delivery
    # return jump_to(previous_step) unless order.addresses.presence

    @deliveries = Delivery.all
  end

  def payment
    return jump_to(previous_step) unless current_order.delivery

    @credit_card = current_order.credit_card || current_user.credit_card || CreditCard.new
  end

  def confirm
    return jump_to(previous_step) unless current_order.credit_card
  end

  def complete
    return jump_to(previous_step) unless session[:order_complete]

    @order = current_user.orders.in_queue.last
    OrderMailer.confirm_order(current_user).deliver_now
    session[:order_complete] = false
  end

  private

  # def show_addresses_params
  #   return { order_id: order.id } if order.addresses.any?
  #
  #   { user_id: user.id }
  # end
end

# def login(options = nil)
#   options[:from_checkout] = { value: true, expires: 1.day.from_now }
# end
#
# def addresses(options = nil)
#   AddressesForm.new(show_addresses_params)
# end
#
# def delivery(options = nil)
#   Delivery.all
# end
#
# def payment(options = nil)
#   order.credit_card || user.credit_card || CreditCard.new
# end
#
# def confirm(options = nil); end
#
# def complete(options = nil)
#   OrderMailer.confirm_order(user).deliver_now
#   options[:order_complete] = false
#   user.orders.in_queue.last
# end
