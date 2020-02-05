class CartsController < ApplicationController
  def show
    @order = current_order
  end

  def update
    coupon&.update(order_id: current_order.id)

    redirect_to cart_path, notice: coupon ? I18n.t(:coupon_applied) : I18n.t(:coupon_not_applied)
  end

  private

  def coupon
    @coupon ||= Coupon.active.find_by(code: params[:coupon])
  end
end
