require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'POST #create' do
    let(:line_item_params) { { line_item: { quantity: 1, book_id: book.id } } }
    before { post :create, params: line_item_params }

    it 'assign @line_item' do
      subject { assigns(:line_item) }
      is_expected.not_to match(nil)
    end

    it 'return redirect response' do
      expect(response.status).to eq(302)
    end
  end

  describe 'PUT #update' do
    before do
      @line_item = create(:line_item)
      session[:line_item_ids] = [@line_item.id]
      put :update, params: { id: @line_item.id, line_item: { quantity: 2 } }
    end

    it 'assign @line_item' do
      subject { assigns(:line_item) }
      is_expected.not_to match(nil)
    end

    it 'return redirect response' do
      expect(response.status).to eq(302)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @line_item = create(:line_item)
      session[:line_item_ids] = [@line_item.id]
      put :destroy, params: { id: @line_item.id, line_item: { quantity: 1 } }
    end

    it 'return redirect response' do
      expect(response.status).to eq(302)
    end
  end
end
