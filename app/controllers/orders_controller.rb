class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = OrderSearch.new(current_user, order_filter_service.order_status).call
    @active_filter = order_filter_service.set_active_filter
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end

  private

  def order_filter_service
    @order_filter_service ||= OrderFilterService.new(params)
  end
end
