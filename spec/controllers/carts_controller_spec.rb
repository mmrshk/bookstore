require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    before { get :show }

    it 'assign @order' do
      expect(assigns(:order)).not_to be_nil
    end

    it 'return success response with show template' do
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end
  end

  describe 'PUT #update' do
    let(:coupon) { create(:coupon) }

    it 'set coupon' do
      expect(controller).to receive(:coupon).at_least(:once)
      put :update
    end

    # context 'valid coupon' do
    #   before do
    #     put :update, params: { coupon: '6584798596', active: true }
    #   end
    #
    #   it 'redirect to Cart' do
    #     expect(response).to redirect_to cart_path
    #   end
    #
    #   it 'show success message' do
    #     expect(flash[:notice]).to eq I18n.t(:coupon_applied)
    #   end
    # end

    context 'fake coupon' do
      before { put :update, params: { coupon: '0000000000', active: true } }

      it 'redirect to Cart' do
        expect(response).to redirect_to cart_path
      end

      it 'show error message' do
        expect(flash[:notice]).to eq I18n.t(:coupon_not_applied)
      end
    end
  end
end
