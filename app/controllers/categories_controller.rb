class CategoriesController < ApplicationController
  include Pagy::Backend
  include CategoryHelper

  before_action :set_filter
  before_action :set_line_item, only: %i[index]

  def index
    @pagy, @books = if params[:category].blank?
                      pagy(Book.by_filter(@filter))
                    else
                      pagy(Book.where(category_id: current_category_id).by_filter(@filter))
                    end
  end

  private

  def current_category_id
    Category.find_by(title: params[:category]).id
  end

  def set_filter
    @filter = Book::FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end

  def set_line_item
    @line_item = LineItem.new
  end
end
