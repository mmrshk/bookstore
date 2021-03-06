require 'rails_helper'

RSpec.describe GenerateCouponService do
  subject(:generate_coupon_service) { described_class }
  let(:coupons) { create_list(:coupon, 3) }
  let(:unique_coupon) { create(:coupon) }

  it 'returns unique coupon' do
    allow(generate_coupon_service).to receive(:generate) { unique_coupon.code }

    coupons.each do |coupon|
      expect(coupon.code).not_to eq(generate_coupon_service.generate)
    end
  end

  it 'checks loop' do
    allow(generate_coupon_service).to receive(:generate) { coupons.first.code }

    coupons.drop(1).each do |coupon|
      expect(generate_coupon_service.generate).not_to eq(coupon.code)
    end

    expect(generate_coupon_service.generate).to eq(coupons.first.code)
  end
end
