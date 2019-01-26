class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @order = Order.new(line_item_ids: session[:line_item_ids],
                       coupon_id: session[:coupon_id])
  end

  def update
    session[:coupon_id] = coupon.id if coupon

    redirect_to cart_path, notice: coupon ? 'Coupon applied' : 'Invalid coupon'
  end

  private

  def coupon
    @coupon ||= Coupon.find_by(active: true, coupon: params[:"/cart"][:coupon_id])
  end
end
