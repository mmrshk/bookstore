class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  private

  def current_order
    return Order.new unless session[:order_id]

    Order.find_by(id: session[:order_id])
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session)
  end
end
