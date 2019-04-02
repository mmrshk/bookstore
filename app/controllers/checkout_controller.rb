class CheckoutController < ApplicationController
  include Wicked::Wizard
  attr_reader :step

  authorize_resource class: false

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

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
    return jump_to(previous_step) if Checkout::ConditionStepService.new(current_order: current_order, step: step,
                                                                        order_complete: session[:order_complete]).call

    @checkout = Checkout::ShowService.new(current_user: current_user, current_order: current_order, step: step,
                                          session: session).call
  end

  def handle_update_step
    @checkout = Checkout::SetupService.new(current_user: current_user, current_order: current_order, step: step,
                                           params: params).call

    render_wizard(@checkout) if step == :addresses || step == :payment
    Checkout::UpdateParamsService.new(current_order: current_order, step: step, session: session,
                                      credit_card: @checkout, params: params).call
  end

  def login
    return cookies[:from_checkout] = { value: true, expires: 1.day.from_now } unless user_signed_in?

    current_order.update(user_id: current_user.id) unless current_order.user_id
    jump_to(current_order.step)
  end
end
