class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  private

  def current_order
    order = session[:order_id] ? Order.find_by(id: session[:order_id]) : Order.create

    if session[:order_id]
      order.update(line_item_ids: session[:line_item_ids], coupon_id: current_coupon)
    else
      session[:order_id] = order.id
    end

    order
  end

  def current_coupon
    current_coupon = Coupon.active.find_by(order_id: session[:order_id])

    current_coupon&.id
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session, current_order)
  end
end
