class ApplicationController < ActionController::Base
  include Pagy::Backend
  helper_method :current_order

  private

  def current_order
    return Order.new unless session[:order_id]

    Order.find(session[:order_id])
  end
end
