class PagesController < ApplicationController
  DIGIT_LATEST_BOOKS = 3
  DIGIT_BOOK_BEST_SELLERS = 4

  def index
    @latest_books = Book.last(DIGIT_LATEST_BOOKS)
    @best_sellers = BookBestSellers.new.call.first(DIGIT_BOOK_BEST_SELLERS)
  end
end
