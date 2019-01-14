class CartsController < ApplicationController
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart, only: [:show, :index, :update]
  before_action :total_price_init, :discount_init, :subtotal_price_init

  def index
    redirect_to root_path if Cart.none?

    redirect_to cart_path(session[:cart_id])
  end

  def show
  end

  def new
    @cart = Cart.new
  end

  def update
    return redirect_to cart_path(session[:cart_id]) if coupon_not_exist?


    @coupon = Coupon.all.find_by(coupon: params[:cart][:coupon_id])
    @discount = discount(@total_price, @coupon)
    @total_price -= @discount
    #@cart.coupon_id = @coupon.id
    #@cart.save

    render "show"
  end

  private

  def subtotal_price_init
    @subtotal = @cart.total_price
  end

  def total_price_init
    @total_price = @cart.total_price
  end

  def discount_init
    @discount = 0
  end

  def discount(total_price, coupon)
    total_price * coupon.sale / 100
  end

  def coupon_not_exist?
    Coupon.all.find_by(coupon: params[:cart][:coupon_id]).nil?
  end

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, notice: "That cart doesn't exists."
  end
end
