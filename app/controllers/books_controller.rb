class BooksController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource

  include Pagy::Backend

  before_action :set_line_item, :set_filter

  def index
    @pagy, @books = @category ? pagy(PagyService.new.filter_by_category(@category, @filter)) : pagy(PagyService.new.default_filter(@filter))
  end

  def show; end

  private

  def set_line_item
    @line_item = LineItem.new
  end

  def set_filter
    @filter = BookFilterService.new.filter(params)
  end
end
