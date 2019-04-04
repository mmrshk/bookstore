class Checkout::ConditionStepService
  attr_reader :step, :order, :is_complete

  def initialize(order:, step:, is_complete:)
    @order = order
    @step = step
    @is_complete = is_complete
  end

  def call
    case step
    when :addresses then false
    when :delivery  then order.addresses.none?
    when :payment   then !order.delivery
    when :confirm   then !order.credit_card
    when :complete  then !is_complete
    end
  end
end
