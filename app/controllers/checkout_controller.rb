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
    return jump_to(previous_step) if Checkout::ConditionStepService.new(current_order: current_order,
                                                                        step: step, session: session).call

    @checkout = Checkout::ShowService.new(current_user: current_user, current_order: current_order, step: step,
                                          session: session).call
  end

  def handle_update_step
    @checkout = Checkout::UpdateService.new(current_user: current_user, current_order: current_order, step: step,
                                            session: session, params: params).call

    render_wizard(@checkout) if step == :addresses || step == :payment
    Checkout::UpdateParamsService.new(current_order: current_order, step: step, session: session,
                                      credit_card: @checkout, params: params).call
  end

  def login
    return jump_to(current_order.step) if user_signed_in?

    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def set_order
    return if session[:order_id] || %i[login complete].include?(step)

    @order = Checkout::OrderService.call(session, current_user)
    session[:order_id] = @order.id
  end
end
