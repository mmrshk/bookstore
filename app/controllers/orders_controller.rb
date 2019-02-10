class OrdersController < ApplicationController
  def index
    order_status = params[:order_status] || Order::ORDER_FILTERS.key('All')
    @orders = OrderSearch.new(current_user, order_status).call.decorate
    @active_filter = order_status ? Order::ORDER_FILTERS[order_status.to_sym] : Order::ORDER_FILTERS.key('All')
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end
end
