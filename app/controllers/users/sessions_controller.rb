class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
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
end
