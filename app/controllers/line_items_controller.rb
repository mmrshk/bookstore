class LineItemsController < ApplicationController
  load_and_authorize_resource
  
  include CurrentCart
  before_action :set_line_item, only: [:update, :destroy]
  before_action :set_cart, only: [:create]

  QUANTITY = {
    increment: "increment",
    decrement: "decrement"
  }

  def index
    @line_items = LineItem.all
  end

  def edit
    @book = Book.find(params[:book_id])
    @line_items = LineItem.all
    current_item = @line_items.find_by(book_id: @book)
    quantity_change!(current_item)
    redirect_to cart_path(session[:cart_id])
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy

    redirect_to cart_path(session[:cart_id])
  end

  def create
    book = Book.find(params[:book_id])
    @line_item = @cart.add_book(book)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: "Item added to cart."}
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:book_id, :quantity)
  end

  def quantity_change!(current_item)
    case params[:quantity]
    when QUANTITY[:increment] then current_item.increment!(:quantity)
    when QUANTITY[:decrement] then current_item.decrement!(:quantity) if current_item.quantity.positive?
    end
  end
end
