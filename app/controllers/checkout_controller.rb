class CheckoutController < ApplicationController
  include Wicked::Wizard
  attr_reader :step

  authorize_resource class: false

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    if current_order.line_items.none? && step != :complete
      return redirect_to root_path, danger: I18n.t('controllers.checkout.error')
    end

    step == :login ? login : handle_show_step
    render_wizard
  end

  def update
    handle_update_step
    redirect_to next_wizard_path unless performed?
  end

  private

  def handle_show_step
    if Checkout::ConditionStepService.new(order: current_order, step: step, is_complete: session[:order_complete]).call
      return jump_to(previous_step)
    end

    @checkout = Checkout::ShowService.new(current_order: current_order, step: step, session: session).call
  end

  # def handle_update_step
    # use only current_order
    # rename to checkoutable
    # @checkout = Checkout::SetupService.new(current_order: current_order, step: step, params: params).call

    # render_wizard(@checkout) if step == :addresses || step == :payment
    # render_wizard of service calling result
    # Checkout::UpdateParamsService.new(current_order: current_order, step: step, session: session,
                                      # credit_card: @checkout, params: params).call
  # end

  def handle_update_step
    @checkout = Checkout::UpdateParamsService.new(order: current_order, step: step, session: session, params: params).call

    render_wizard if @checkout
  end

  def login
    unless user_signed_in?
      cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
      return
    end

    current_order.update(user_id: current_user.id) unless current_order.user_id
    jump_to(current_order.step)
  end
end
