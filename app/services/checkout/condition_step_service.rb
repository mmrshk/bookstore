class Checkout::ConditionStepService
  attr_reader :step, :order, :session, :user

  def initialize(current_user:, current_order:, step:, session:)
    @user = current_user
    @order = current_order
    @step = step
    @session = session
  end

  def call
    case step
    when :addresses then user.nil?
    when :delivery  then !order.addresses.presence
    when :payment   then !order.delivery
    when :confirm   then !order.credit_card
    when :complete  then !session[:order_complete]
    end
  end
end
