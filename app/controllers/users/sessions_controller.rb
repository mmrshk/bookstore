class Users::SessionsController < Devise::SessionsController
  def new
    cookies.delete :from_checkout

    super
  end

  def after_sign_in_path_for(resource)
    cookies[:line_item_ids] = { value: session[:line_item_ids].to_json }

    return super unless cookies[:from_checkout]

    cookies.delete :from_checkout
    checkout_path(:addresses)
  end

  def after_sign_out_path_for(resource)
    session[:line_item_ids] = JSON.parse(cookies[:line_item_ids])
    current_order.destroy
    super
  end
end
