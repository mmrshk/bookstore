require 'rails_helper'

RSpec.describe Delivery, type: :model do
  it { is_expected.to have_many(:orders).dependent(:destroy)  }

  %i[name time price].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end

  it { expect(subject).to validate_length_of(:name).is_at_most(50) }
  it { expect(subject).to validate_numericality_of(:price) }
end
