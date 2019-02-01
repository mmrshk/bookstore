class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :find_book,     only: %i[show]
  before_action :set_line_item, only: %i[show]

  def show
    @category = Category.where(name: @book.category)
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
  end

  def set_line_item
    @line_item = LineItem.new
  end
end
