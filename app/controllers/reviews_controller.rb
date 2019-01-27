class ReviewsController < ApplicationController
  load_and_authorize_resource

  before_action :find_book

  def create
    @review = Review.new(review_params)
    @review.rating = review_rating

    if @review.save
      flash[:notice] = 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      flash[:error] = 'Review not applied.'
    end

    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :name, :book_id, :user_id)
  end

  def review_rating
    return 0 unless params[:rating]

    params.require(:rating)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end
end
