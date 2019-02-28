class PagesController < ApplicationController
  authorize_resource class: false

  COUNT_LATEST_BOOKS = 3
  COUNT_BOOK_BEST_SELLERS = 4

  def home
    @latest_books = Book.last(COUNT_LATEST_BOOKS)
    @best_sellers = BookBestSellers.new.call.first(COUNT_BOOK_BEST_SELLERS)
  end
end
