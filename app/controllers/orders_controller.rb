class OrdersController < ApplicationController
  def index
    order_status = params[:order_status]
    order_status = ORDER_FILTERS[:all] unless order_status
    @orders = OrderSearch.new(current_user, order_status).call
    @active_filter = order_status ? Order::ORDER_FILTERS[order_status.to_sym] : Order::ORDER_FILTERS[:all]
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
