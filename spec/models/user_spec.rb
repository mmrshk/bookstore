require 'rails_helper'

RSpec.describe User, type: :model do
  %i[reviews addresses orders].each do |field|
    it { is_expected.to have_many(field).dependent(:destroy) }
  end

  it { is_expected.to have_many(:line_items).through(:orders).dependent(:destroy) }
  it { is_expected.to have_many(:books).through(:line_items).dependent(:destroy) }
  it { is_expected.to have_one(:credit_card).dependent(:destroy) }
end
