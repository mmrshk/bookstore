class CategoriesController < ApplicationController
  include Pagy::Backend
  include CategoryHelper

  before_action :set_filter
  before_action :set_line_item

  def index
    @pagy, @books = pagy(Book.by_filter(@filter))
  end

  def show
    @pagy, @books = pagy(Book.where(category_id: params[:id]).by_filter(@filter))
  end

  private

  def set_filter
    @filter = Book::FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end

  def set_line_item
    @line_item = LineItem.new
  end
end
