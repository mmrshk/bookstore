require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review) { create(:review) }
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:review_params) do
      { book_id: book.id,
        review: { comment: review.comment, name: review.name, user_id: user.id, rating: review.rating } }
    end

    before do
      sign_in(user)
      post :create, xhr: true, params: review_params
    end

    it 'assign @review' do
      subject { assigns(:review) }
      is_expected.not_to match(nil)
    end

    it 'return redirect response' do
      expect(response.status).to eq(302)
    end
  end
end
