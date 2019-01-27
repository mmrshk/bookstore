class LineItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  load_and_authorize_resource

  QUANTITY = {
    increment: 'increment',
    decrement: 'decrement'
  }.freeze

  def edit
    quantity_change!(LineItem.all.find_by(id: params[:id]))

    redirect_to cart_path
  end

  def create
    @line_item = LineItem.find_or_initialize_by(book_id: params[:line_item][:book_id]).tap do |item|
      item.quantity += params[:line_item][:quantity].to_i
    end

    @line_item.save!
    create_new_line_item

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
    return if line_item_ids.include?(@line_item.id)

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
    when QUANTITY[:increment] then current_item.increment(:quantity)
    when QUANTITY[:decrement] then current_item.decrement(:quantity) if current_item.quantity.positive?
    end
  end
end
