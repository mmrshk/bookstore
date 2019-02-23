class CartsController < ApplicationController
  def show
    @order = Order.new(line_item_ids: session[:line_item_ids], coupon_id: session[:coupon_id])
  end

  def update
    session[:coupon_id] = coupon.id if coupon
    redirect_to cart_path, notice: coupon ? I18n.t(:coupon_applied) : I18n.t(:coupon_not_applied)
  end

  private

  def coupon
    @coupon ||= Coupon.active.find_by(coupon: params[:coupon])
  end
end
