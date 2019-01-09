class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    @carts = Cart.all
    redirect_to cart_path(session[:cart_id])
  end

  def show
  end

  def new
    @cart = Cart.new
  end

  def edit
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, notice: "That cart doesn't exists."
  end
end
