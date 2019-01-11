class BooksController < ApplicationController
  before_action :find_book, only: [:show]

  def index
    @latest_books = Book.latest_books
  end

  def show
    @category = Category.find_by(title: @book.category)
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end
end
