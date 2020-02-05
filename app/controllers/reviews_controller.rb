class ReviewsController < ApplicationController
  load_resource
  load_resource :book

  def create
    if @review.save
      flash[:success] = I18n.t(:review_applied)
    else
      flash[:danger] = I18n.t(:review_not_applied)
    end

    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(%i[comment name book_id user_id rating])
  end
end
