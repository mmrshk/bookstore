class OrdersController < ApplicationController
  decorates_assigned :order

  def index
    order_status = params[:order_status] || Order::ORDER_FILTERS[:all_orders]
    @orders = OrderSearch.new(current_user, order_status).call.decorate
    @active_filter = order_status ? Order::ORDER_FILTERS[order_status.to_sym] : Order::ORDER_FILTERS[:all_orders]
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end
end
