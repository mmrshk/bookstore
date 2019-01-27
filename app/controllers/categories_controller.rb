class CategoriesController < ApplicationController
  before_action :set_filter
  before_action :set_line_item, only: %i[index]

  def index
    @pagy, @books = pagy(Book.by_filter(@filter))
    return @books if params[:category].blank?

    @pagy, @books = pagy(Book.where(category_id: Category.find_by(title: params[:category]).id).by_filter(@filter))
  end

  private

  def set_filter
    @filter = Book::FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end

  def set_line_item
    @line_item = LineItem.new
  end
end
