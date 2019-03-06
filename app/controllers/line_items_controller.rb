class LineItemsController < ApplicationController
  load_and_authorize_resource

  def create
    @line_item = LineItemsService.new(@line_item, line_item_params).create

    if @line_item.save
      create_new_line_item
      flash[:success] = I18n.t('controllers.line_item.line_item_created')
    else
      flash[:danger] = I18n.t('controllers.line_item.line_item_not_created')
    end

    redirect_to books_path
  end

  def update
    LineItemsService.new(@line_item, line_item_params).quantity_change!
    redirect_to cart_path
  end

  def destroy
    LineItemsService.new(@line_item, line_item_params).destroy

    if @line_item.destroy
      destroy_line_item
      flash[:success] = I18n.t('controllers.line_item.line_item_deleted')
    else
      flash[:danger] = I18n.t('controllers.line_item.line_item_not_deleted')
    end

    redirect_to cart_path
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :book_id)
  end

  def line_item_ids
    session[:line_item_ids] ||= []
  end

  def create_new_line_item
    return if line_item_ids.include?(@line_item.id)

    line_item_ids << @line_item.id
  end

  def destroy_line_item
    line_item_ids.delete_if { |item_id| item_id == @line_item.id }
  end
end
