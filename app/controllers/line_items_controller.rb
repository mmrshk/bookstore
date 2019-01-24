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
    begin
      existed_line_item = LineItem.where(id: line_item_ids).find_by(book_id: @line_item.book_id)
      existed_line_item.quantity += @line_item.quantity
      existed_line_item.save!
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordNotUnique, NoMethodError
      create_new_line_item
    end
    redirect_to cart_path
  end

  def destroy
    @line_item = LineItem.all.find_by(id: params[:id])
    @line_item.destroy
    line_item_ids.delete_if { |item_id| item_id == @line_item.id }

    redirect_to cart_path
  end

  private
  
  def create_new_line_item
    @line_item = LineItem.create(line_item_params)
    @line_item.save!
    line_item_ids << @line_item.id
  end

  def line_item_ids
    session[:line_item_ids] ||= []
  end

  def line_item_params
    params.require(:line_item).permit(:quantity, :book_id)
  end

  def quantity_change!(current_item)
    case params[:quantity]
    when QUANTITY[:increment] then current_item.increment!(:quantity)
    when QUANTITY[:decrement] then current_item.decrement!(:quantity) if current_item.quantity.positive?
    end
  end
end
