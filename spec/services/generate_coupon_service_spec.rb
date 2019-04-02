require 'rails_helper'

RSpec.describe GenerateCouponService do
  subject(:generate_coupon_service) { described_class }
  let(:coupons) { create_list(:coupon, 3) }
  let(:unique_coupon) { create(:coupon) }

  it 'returns unique coupon' do
    allow(Coupon).to receive_message_chain(:where, :none?) { true }
    allow(generate_coupon_service).to receive(:generate) { unique_coupon.code }

    coupons.each do |coupon|
      expect(coupon.code).not_to eq(generate_coupon_service.generate)
    end
  end

  it 'checks loop' do
    allow(Coupon).to receive_message_chain(:where, :none?).and_return(false, false, true)
    allow(generate_coupon_service).to receive(:generate) { coupons.first.code }

    coupons.drop(1).each  do |coupon|
      expect(coupon.code).not_to eq(generate_coupon_service.generate)
    end

    expect(coupons.first.code).to eq(generate_coupon_service.generate)
  end
end
