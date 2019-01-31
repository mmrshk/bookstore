class ReviewsController < ApplicationController
  load_and_authorize_resource

  before_action :find_book

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:success] =  I18n.t(:review_applied)
    else
      flash[:danger] = I18n.t(:review_not_applied)
    end

    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :name, :book_id, :user_id, :rating)
  end

  def find_book
    @book = Book.find_by(id: params[:book_id])
  end
end
