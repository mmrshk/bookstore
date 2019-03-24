require 'rails_helper'

RSpec.describe Address, type: :model do
  %i[firstname lastname address city zip country phone cast].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end

  %i[firstname lastname address city country].each do |field|
    it { expect(subject).to validate_length_of(field).is_at_most(50) }
  end

  it { expect(subject).to validate_length_of(:phone).is_at_most(15) }
  it { expect(subject).to validate_length_of(:zip).is_at_most(10) }
  it { expect(subject).to allow_value('Dmitriy').for(:firstname) }
  it { expect(subject).to allow_value('Bavykin').for(:lastname) }
  it { expect(subject).to allow_value('Dievka').for(:city) }
  it { expect(subject).to allow_value('Dievka selo, 7').for(:address) }
  it { expect(subject).not_to allow_value('!@#$%^&*()_+:;').for(:firstname) }
  it { expect(subject).not_to allow_value('!@#$%^&*()_+:;').for(:lastname) }
  it { expect(subject).not_to allow_value('!@#$%^&*()_+:;').for(:city) }
  it { is_expected.to belong_to(:addressable) }
  it { expect(Address.casts['billing']).to eq(0) }
  it { expect(Address.casts['shipping']).to eq(1) }
end
