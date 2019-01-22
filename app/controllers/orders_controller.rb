class OrdersController < ApplicationController
  ORDER_STATUSES = {
    in_queue: 'Waiting for processing',
    in_delivery: 'In delivery',
    delivered: 'Delivery',
    canceled: 'Canceled',
    all: 'All'
  }.freeze

  def index
    order_status = params[:order_status]

    @orders = case order_status
              when 'in_queue' then current_user.orders.in_queue
              when 'in_delivery' then current_user.orders.in_delivery
              when 'delivered' then current_user.orders.delivered
              when 'canceled' then current_user.orders.canceled
              else current_user.orders.all_orders
              end
    @active_filter = order_status ? ORDER_STATUSES[order_status.to_sym] : 'All'
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
