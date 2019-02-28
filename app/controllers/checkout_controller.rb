class CheckoutController < ApplicationController
  authorize_resource class: false

  include Wicked::Wizard

  before_action :set_order

  steps :login, :addresses, :delivery, :payment, :confirm, :complete
  attr_reader :step

  def show
    return redirect_to root_path if session[:line_item_ids].nil? && step == :addresses

    case step
    when :login     then login
    when :addresses then @addresses   = render_show
    when :delivery  then @deliveries  = render_show(!current_user.addresses.presence)
    when :payment   then @credit_card = render_show(!current_order.delivery)
    when :confirm   then render_show(!current_order.credit_card)
    when :complete  then @order = render_show(!session[:order_complete], { order_complete: session[:order_complete] })
    end
    render_wizard
  end

  def update
    case step
    when :addresses then update_addresses
    when :delivery  then update_delivery
    when :payment   then update_payment
    when :confirm   then update_confirm
    when :complete  then update_complete
    end
    redirect_to next_wizard_path unless performed?
  end

  private

  def update_addresses
    @addresses = AddressesForm.new(addresses_params)
    UpdateParamsCheckoutService.update_addresses(current_order)
    render_wizard if !@addresses.save
  end

  def update_delivery
    UpdateParamsCheckoutService.update_delivery(current_order, order_params)
    flash[:warning] = I18n.t(:choose_delivery_method) if current_order.delivery_id.nil?
  end

  def update_payment
    @credit_card = CreditCard.new(credit_card_params)
    render_wizard if !@credit_card.save
    UpdateParamsCheckoutService.update_payment(current_order, @credit_card)
  end

  def update_confirm
    UpdateParamsCheckoutService.update_confirm(current_order, session)
  end

  def render_show(condition = nil, options = {})
    return jump_to(previous_step) if condition

    ShowCheckoutService.new(current_user, current_order).public_send(step, options)
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

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def credit_card_params
    params.require(:credit_card).permit(:name, :card_number, :cvv, :expiration_month_year)
  end

  def addresses_params
    params.require(:addresses_form)
  end
end
