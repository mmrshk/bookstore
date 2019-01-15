class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :find_book, only: [:show]

  def show

    @category = Category.where(name: @book.category)
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end
end
