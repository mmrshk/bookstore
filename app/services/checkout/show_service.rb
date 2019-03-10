class Checkout::ShowService
  attr_reader :user, :order, :params, :session

  def initialize(current_user:, current_order:, step:, session:)
    @user = current_user
    @order = current_order
    @step = step
    @session = session
  end

  def call
    public_send(@step)
  end

  def addresses
    AddressesForm.new(user, order)
  end

  def delivery
    Delivery.all
  end

  def payment
    order.credit_card || user.credit_card || CreditCard.new
  end

  def confirm; end

  def complete
    OrderMailer.confirm_order(user).deliver_now
    session[:order_complete] = false
    user.orders.in_queue.last
  end

  # private
  #
  # def addresses_model_params
  #   return { addressable_id: user.id, addressable_type: "User" } if user.addresses.any?
  #
  #   { addressable_id: order.id, addressable_type: "Order" }
  # end
end
