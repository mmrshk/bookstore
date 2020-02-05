require 'rails_helper'

RSpec.describe User, type: :model do
  %i[reviews addresses orders].each do |field|
    it { expect(subject).to have_many(field).dependent(:destroy) }
  end

  it { expect(subject).to have_many(:line_items).through(:orders).dependent(:destroy) }
  it { expect(subject).to have_many(:books).through(:line_items).dependent(:destroy) }
  it { expect(subject).to have_one(:credit_card).dependent(:destroy) }
end
