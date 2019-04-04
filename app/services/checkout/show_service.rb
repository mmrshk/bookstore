class Checkout::ShowService
  attr_reader :user, :order, :params, :session

  def initialize(current_order:, step:, session:)
    @order = current_order
    @user = current_order.user
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
end
