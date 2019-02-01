class ApplicationController < ActionController::Base
  helper_method :current_order
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    cookies[:line_item_ids] = { value: ActiveSupport::JSON.encode(session[:line_item_ids]) }
    if cookies[:from_checkout]
      cookies.delete :from_checkout
      checkout_path(:addresses)
    else
      super
    end
  end

  def after_sign_out_path_for(resource)
    session[:line_item_ids] = ActiveSupport::JSON.decode(cookies[:line_item_ids])
    current_order.destroy
    super
  end

  private

  def current_order
    return Order.new unless session[:order_id]

    Order.find_by(id: session[:order_id])
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session)
  end
end
