class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :set_order

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to root_path if session[:line_item_ids].nil? && step == :addresses

    case step
    when :login then login
    when :addresses then show_addresses
    when :delivery then show_delivery
    when :payment then show_payment
    when :confirm then show_confirm
    when :complete then show_complete
    end
    render_wizard
  end

  def update
    case step
    when :addresses then update_addresses
    when :delivery then update_delivery
    when :payment then update_payment
    when :confirm then update_confirm
    when :complete then update_complete
    end
    redirect_to next_wizard_path unless performed?
  end

  private

  def login
    return jump_to(next_step) if user_signed_in?

    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def show_delivery
    return jump_to(previous_step) unless current_user.addresses.presence

    @deliveries = Delivery.all
  end

  def show_addresses
    @addresses = AddressesForm.new(show_addresses_params)
  end

  def show_payment
    return jump_to(previous_step) unless current_order.delivery

    @credit_card = current_order.credit_card || current_user.credit_card || CreditCard.new
  end

  def show_confirm
    return jump_to(previous_step) unless current_order.credit_card
  end

  def show_complete
    return jump_to(previous_step) unless session[:order_complete]

    @order = current_user.orders.in_queue.last
    OrderMailer.confirm_order(current_user).deliver_now
    session[:order_complete] = false
  end

  def update_addresses
    @addresses = AddressesForm.new(addresses_params)

    render_wizard unless @addresses.save
  end

  def update_delivery
    current_order.update(order_params)
    flash[:warning] = 'Please choose delivery method.' if current_order.delivery_id.nil?
  end

  def update_payment
    @credit_card = CreditCard.new(credit_card_params)
    render_wizard unless @credit_card.save
    current_order.update(credit_card_id: @credit_card.id)
  end

  def update_confirm
    session[:order_complete] = true
    current_order.place_in_queue
    current_order.coupon.update(active: false) if current_order.coupon
    session[:order_id] = nil
    session[:line_item_ids] = nil
    session[:coupon_id] = nil
  end

  def set_order
    return if session[:order_id] || %i[login complete].include?(step)

    @order = Order.new(line_item_ids: session[:line_item_ids],
                       coupon_id: session[:coupon_id],
                       user_id: current_user.id)
    @order.save
    session[:order_id] = @order.id
  end

  def show_addresses_params
    return { addressable_type: 'User', addressable_id: current_user.id } if current_order.addresses.empty?

    { addressable_type: 'Order', addressable_id: current_order.id }
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
