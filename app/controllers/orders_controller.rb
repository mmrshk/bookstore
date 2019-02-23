class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    order_status = params[:order_status] || OrderFilterService.key_all
    @orders = OrderSearch.new(current_user, order_status).call.decorate
    @active_filter = order_status ? OrderFilterService.key_set(order_status) : OrderFilterService.key_all
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end
end
