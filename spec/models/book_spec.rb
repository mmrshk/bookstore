require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { build(:book) }

  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to belong_to(:category) }

  %i[reviews line_items].each do |field|
    it { is_expected.to have_many(field).dependent(:destroy) }
  end

  %i[title price quantity dimension_d dimension_h dimension_w].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end

  it { expect(subject).to validate_numericality_of(:year).is_less_than_or_equal_to(Time.current.year) }
  it { expect(subject).to validate_numericality_of(:price).only_integer }
end
