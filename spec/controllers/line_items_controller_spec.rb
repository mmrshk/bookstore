require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'POST #create' do
    let(:line_item_params) { { line_item: attributes_for(:line_item) } }
    before { post :create, params: line_item_params }

    it 'assigns @line_item' do
      expect(assigns(:line_item)).to be_a LineItem
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    before do
      @line_item = create(:line_item)
      session[:line_item_ids] = [@line_item.id]
      put :update, params: { id: @line_item.id, line_item: attributes_for(:line_item, quantity: 2) }
    end

    it 'assigns @line_item' do
      expect(assigns(:line_item)).to be_a LineItem
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @line_item = create(:line_item)
      session[:line_item_ids] = [@line_item.id]
      put :destroy, params: { id: @line_item.id, line_item: attributes_for(:line_item, quantity: 1) }
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end
