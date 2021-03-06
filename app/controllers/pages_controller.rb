class PagesController < ApplicationController
  DIGIT_LATEST_BOOKS = 3
  DIGIT_BOOK_BEST_SELLERS = 4

  def home
    @latest_books = Book.last(DIGIT_LATEST_BOOKS)
    @best_sellers = BookBestSellers.call.first(DIGIT_BOOK_BEST_SELLERS)
  end
end
