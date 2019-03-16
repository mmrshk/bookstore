require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
  it { is_expected.to have_many(:addresses).dependent(:destroy) }
  it { is_expected.to have_many(:orders).dependent(:destroy) }
  it { is_expected.to have_many(:line_items).through(:orders).dependent(:destroy) }
  it { is_expected.to have_many(:books).through(:line_items).dependent(:destroy) }
  it { is_expected.to have_one(:credit_card).dependent(:destroy) }
end
