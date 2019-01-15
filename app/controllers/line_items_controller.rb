class LineItemsController < ApplicationController
  load_and_authorize_resource

  QUANTITY = {
    increment: "increment",
    decrement: "decrement"
  }

  def edit
    quantity_change!(LineItem.all.find_by(id: params[:id]))

    redirect_to cart_path
  end

  def create
    @line_item = LineItem.create(line_item_params)
    line_item_ids << @line_item.id

    redirect_to cart_path
  end

  def update
    @line_item.update_attributes(line_item_params)
    @line_items = LineItem.where(id: line_item_ids)
    
    redirect_to cart_path
  end

  def destroy
    @line_item = LineItem.all.find_by(id: params[:id])
    @line_item.destroy
    line_item_ids.delete_if { |item_id| item_id == @line_item.id }

    redirect_to cart_path
  end

  private

  def line_item_ids
    session[:line_item_ids] ||= []
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
