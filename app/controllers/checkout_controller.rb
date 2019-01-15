class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :set_order

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to root_path if session[:line_item_ids].nil? && step == :address

    case step
    when :login then login
    when :addresses then show_addresses
    when :delivery then show_delivery
    end
    render_wizard
  end

  def update
    case step
    when :addresses then update_addresses
    when :delivery then update_delivery
    end
    redirect_to next_wizard_path unless performed?
  end

  private

  def login
    return jump_to(next_step) if user_signed_in?

    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def show_delivery

  end

  def show_addresses
    @addresses = Address.new(show_addresses_params)
  end

  def update_addresses
    @addresses = Address.new(firstname: params[:address][:address][:firstname],
                             lastname: params[:address][:address][:lastname],
                             address: params[:address][:address][:address],
                             city: params[:address][:address][:city],
                             zip: params[:address][:address][:zip],
                             country: params[:address][:address][:country],
                             phone: params[:address][:address][:phone],
                             cast: params[:address][:address][:cast],
                             addressable_type: "Order",
                             addressable_id: current_order.id)
    render_wizard unless @addresses.save
  end

  def set_order
    return if session[:order_id]

    @order = Order.new(line_item_ids: session[:line_item_ids],
                       coupon_id: session[:coupon_id],
                       user_id: current_user.id)
    @order.save
    session[:order_id] = @order.id
  end

  def show_addresses_params
    return { addressable_type: "User", addressable_id: current_user.id } if current_order.addresses.empty?

    { addressable_type: "Order", addressable_id: current_order.id }
  end

  def addresses_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end
end
