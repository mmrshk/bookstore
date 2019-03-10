require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:delivery) }
  it { should belong_to(:credit_card) }

  it { should have_many(:line_items).dependent(:destroy) }
  it { should have_many(:addresses).dependent(:destroy) }
  it { should have_one(:coupon) }
end
