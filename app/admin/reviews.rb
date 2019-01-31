ActiveAdmin.register Review do
  permit_params :rating, :comment, :name

  scope :all
  scope :published
  scope :unpublished

  action_item :publish, only: :show do
    link_to 'Publish', publish_admin_review_path(review), method: :put unless review.publish?
  end

  action_item :publish, only: :show do
    link_to 'Unpublish', unpublish_admin_review_path(review), method: :put if review.publish?
  end

  member_action :publish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(publish: true)
    redirect_to admin_review_path(review)
  end

  member_action :unpublish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(publish: false)
    redirect_to admin_review_path(review)
  end
end
