require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:review_params) do
      { book_id: book.id,
        review: attributes_for(:review, book_id: book.id, user_id: user.id) }
    end

    before do
      sign_in(user)
      post :create, xhr: true, params: review_params
    end

    it 'assign @review' do
      expect(assigns(:review)).to match(user.reviews.last)
    end

    it 'return redirect response' do
      expect(response.status).to eq(302)
    end
  end
end
