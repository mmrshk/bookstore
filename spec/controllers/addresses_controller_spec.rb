require 'rails_helper'
TODO
1. Use attributes for
2. Use ONLY rspec matchers

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    let!(:addresses) { create(:address, addressable: user) }

    it 'assign @addresses' do
      expect(assigns(:addresses)).to match_array(user.addresses)
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    let(:address_params) do
      { address: attributes_for(:address) }
    end

    before { post :create, params: address_params }

    it 'assign @address' do
      subject { assigns(:address) }
      is_expected.not_to match(nil)
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    let(:address) { create(:address) }
    let(:address_params) do
      { address: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                   address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                   zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                   phone: '+323424324', cast: 'shipping' }, id: address.id }
    end

    before { put :update, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end
