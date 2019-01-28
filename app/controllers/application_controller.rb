class ApplicationController < ActionController::Base
  include Pagy::Backend
  skip_before_action :verify_authenticity_token
  helper_method :current_order

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    if cookies[:from_checkout]
      cookies.delete :from_checkout
      checkout_path(:addresses)
    else
      super
    end
  end

  private

  def current_order
    return Order.new unless session[:order_id]

    Order.find(session[:order_id])
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session)
  end
end
