require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    before { get :show }

    it 'assign @order' do
      expect(assigns(:order)).to be_a Order
    end

    it 'return success response with show template' do
      expect(response.status).to eq(200)
    end

    it 'render :show template' do
      expect(subject).to render_template(:show)
    end
  end

  describe 'PUT #update' do
    let(:coupon) { create(:coupon) }

    it 'set coupon' do
      expect(controller).to receive(:coupon).at_least(:once)
      put :update
    end

    context 'fake coupon' do
      before { put :update, params: { code: '0000000000', active: true } }

      it 'redirect to Cart' do
        expect(subject).to redirect_to cart_path
      end

      it 'show error message' do
        expect(flash[:notice]).to eq I18n.t(:coupon_not_applied)
      end
    end
  end
end
