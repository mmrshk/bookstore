# class UpdateCheckoutService
#   attr_reader :user, :order
#
#   def initialize(current_user, current_order)
#     @user = current_user
#     @order = current_order
#   end
#
#   def addresses(addresses_params)
#     addresses = AddressesForm.new(addresses_params)
#     return if !addresses.save
#
#     UpdateParamsCheckoutService.update_addresses(order)
#     addresses
#   end
#
#   def delivery(order_params)
#     UpdateParamsCheckoutService.update_delivery(order, order_params)
#     flash[:warning] = I18n.t(:choose_delivery_method) if order.delivery_id.nil?
#   end
#
#   def payment(credit_card_params)
#     credit_card = CreditCard.new(credit_card_params)
#     return if !credit_card.save
#
#     UpdateParamsCheckoutService.update_payment(order, credit_card)
#     credit_card
#   end
#
#   def confirm(session)
#     UpdateParamsCheckoutService.update_confirm(order)
#     session[:order_complete] = true
#     session[:order_id] = nil
#     session[:line_item_ids] = nil
#     session[:coupon_id] = nil
#   end
# end
