class CheckoutController < ApplicationController
  include Wicked::Wizard

  authorize_resource class: false
  before_action :set_order

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  attr_reader :step

  def show
    return redirect_to root_path if session[:line_item_ids].nil? && step == :addresses

    step == :login ? login : handle_show_step
    render_wizard
  end

  def update
    handle_update_step
    redirect_to next_wizard_path unless performed?
  end

  private

  def handle_show_step
    return jump_to(previous_step) if ConditionStepService.new(current_user, current_order, step, session).call

    @checkout = ShowCheckoutService.new(current_user, current_order, step, session).call
  end

  def handle_update_step
    @checkout = UpdateCheckoutService.new(current_user, current_order, step, session, params).call

    render_wizard(@checkout) if step == :addresses || step == :payment
    UpdateParamsCheckoutService.new(current_order, step, session, @checkout, params).call
  end

  def login
    return jump_to(current_order.step) if user_signed_in?

    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def set_order
    return if session[:order_id] || %i[login complete].include?(step)

    @order = OrderCheckoutService.call(session, current_user)
    session[:order_id] = @order.id
  end
end
