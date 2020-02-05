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

    set_order unless current_order.user_id
    @checkoutable = Checkout::ShowService.new(user: current_user, order: current_order, step: step,
                                              session: session).call
  end

  def handle_update_step
    update_service = Checkout::UpdateService.new(order: current_order, step: step, session: session, params: params)
    @checkoutable = update_service.setup_values

    render_wizard unless update_service.valid?
  end

  def login
    return jump_to(current_order.step) if user_signed_in?

    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def set_order
    current_order.update(user_id: current_user.id)
  end
end
