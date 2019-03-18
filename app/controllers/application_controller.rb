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
    if session[:order_id]
      order = Order.find_by(id: session[:order_id])
      order.update(line_item_ids: session[:line_item_ids], coupon_id: session[:coupon_id])

      order
    else
      order = Order.create
      session[:order_id] = order.id

      order
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session, current_order)
  end
end
