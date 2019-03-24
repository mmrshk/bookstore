require 'rails_helper'

RSpec.describe Order, type: :model do
  %i[user delivery credit_card].each do |field|
    it { is_expected.to belong_to(field) }
  end

  %i[line_items addresses].each do |field|
    it { is_expected.to have_many(field).dependent(:destroy) }
  end

  it { is_expected.to have_one(:coupon) }
end
