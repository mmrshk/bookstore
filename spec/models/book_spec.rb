require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { build(:book) }

  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
  it { is_expected.to have_many(:line_items).dependent(:destroy) }

  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:quantity) }
  it { expect(subject).to validate_presence_of(:dimension_d) }
  it { expect(subject).to validate_presence_of(:dimension_h) }
  it { expect(subject).to validate_presence_of(:dimension_w) }
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:title) }

  it { expect(subject).to validate_numericality_of(:year).is_less_than_or_equal_to(Time.current.year) }
  it { expect(subject).to validate_numericality_of(:price).only_integer }
end
