class HomeController < ApplicationController
  def index
    @latest_books = Book.last(3)
  end
end
