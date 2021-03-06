require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user_id: user.id) }

  before do
    sign_in(user)
    session[:order_id] = order.id
  end

  describe 'when cart is empty and step not complete' do
    before { session[:line_item_ids] = nil }

    %i[login addresses delivery payment confirm].each do |step|
      before { get :show, params: { id: step } }

      it "redirects on #{step}" do
        expect(subject).to redirect_to root_path
      end
    end
  end

  describe 'step workflow' do
    context '#show' do
      let(:line_item) { create(:line_item) }
      before { session[:line_item_ids] = [line_item.id] }

      %i[login delivery payment confirm complete].each do |step|
        it "redirects from #{step}" do
          get :show, params: { id: step }
          expect(response).to have_http_status(302)
        end
      end

      it 'renders addresses with success  response' do
        get :show, params: { id: :addresses }
        expect(response).to have_http_status(200)
      end
    end

    context '#update' do
      context 'addressess step' do
        let(:addresses_form) do
          { billing: attributes_for(:address, cast: 'billing'),
            shipping: attributes_for(:address, cast: 'shipping') }
        end

        it 'return a redirect response' do
          put :update, params: { id: :addresses, addresses_form: addresses_form }
          expect(response).to have_http_status(302)
        end
      end

      context 'payment step' do
        let(:credit_card_valid) { attributes_for(:credit_card) }
        let(:credit_card_unvalid) { attributes_for(:credit_card, card_number: '', cvv: '') }

        it 'return redirect response' do
          put :update, params: { id: :payment, credit_card: credit_card_valid }
          expect(response).to have_http_status(302)
        end

        it 'return success response' do
          put :update, params: { id: :payment, credit_card: credit_card_unvalid }
          expect(response).to have_http_status(200)
        end
      end

      context 'confirm step' do
        it 'return a redirect response' do
          put :update, params: { id: :confirm }
          expect(response).to have_http_status(302)
        end
      end

      context 'delivery step' do
        let(:delivery) { create(:delivery) }
        let(:delivery_params) { { delivery_id: delivery.id } }

        it 'return a redirect response' do
          put :update, params: { id: :delivery, order: delivery_params }
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
