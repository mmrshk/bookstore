require 'rails_helper'
# 1. attribute_for

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before { sign_in(user) }

  describe 'when cart is empty and step :addresses' do
    before do
      session[:line_item_ids] = nil
    end

    it do
      get :show, params: { id: :addresses }
      expect(subject).to redirect_to root_path
    end
  end

  describe 'step workflow' do


    context '#show' do
      before do
        session[:line_item_ids] = []
      end

      %i[login addresses delivery payment confirm complete].each do |step|
        it "redirects from #{step}" do
          get :show, params: { id: step }
          expect(response).to have_http_status(302)
        end
      end
    end

    context '#update' do
      context 'addressess step' do
        let(:valid_addresses_form) do
          { billing: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                       address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                       zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                       phone: '+323424324', cast: 'billing' },
            shipping: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                        address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                        zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                        phone: '+323424324', cast: 'shipping' },
            use_billing: 0 }
        end

        let(:unvalid_addresses_form) do
          { billing: { firstname: '', lastname: '',
                       address: '', city: FFaker::Address.city_prefix,
                       zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                       phone: '+323424324', cast: 'billing' },
            shipping: { firstname: '', lastname: '',
                        address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                        zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                        phone: '+323424324', cast: 'shipping' },
            use_billing: 0 }
        end

        it 'return a redirect response' do
          put :update, params: { id: :addresses, addresses_form: valid_addresses_form }
          expect(response).to have_http_status(302)
        end

        it 'return success response' do
          put :update, params: { id: :addresses, addresses_form:  unvalid_addresses_form}
          expect(response).to have_http_status(200)
        end
      end

      context 'payment step' do
        let(:credit_card) do
          { card_number: '1111222233334444',  expiration_month_year: '01/21', cvv: '1234',
            name: "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
        end

        it 'return redirect response' do
          put :update, params: { id: :payment, credit_card: credit_card }
          expect(response).to have_http_status(302)
        end

        it 'return success response' do
          put :update, params: { id: :payment, credit_card: { card_number: '', expiration_month_year: '', cvv: '', name: ''} }
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