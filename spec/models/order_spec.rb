require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:delivery) }
  it { is_expected.to belong_to(:credit_card) }

  it { is_expected.to have_many(:line_items).dependent(:destroy) }
  it { is_expected.to have_many(:addresses).dependent(:destroy) }
  it { is_expected.to have_one(:coupon) }
end
