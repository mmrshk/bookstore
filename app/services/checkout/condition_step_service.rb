class Checkout::ConditionStepService
  attr_reader :step, :order, :order_complete

  def initialize(current_order:, step:, order_complete:)
    @order = current_order
    @step = step
    @order_complete = order_complete
  end

  def call
    case step
    when :addresses then false
    when :delivery  then order.addresses.none?
    when :payment   then !order.delivery
    when :confirm   then !order.credit_card
    when :complete  then !order_complete
    end
  end
end
