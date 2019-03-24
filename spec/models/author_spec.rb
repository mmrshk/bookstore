require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { create(:author) }

  %i[firstname lastname].each do |field|
    it { expect(subject).to validate_presence_of(field) }
    it { expect(subject).to validate_length_of(field).is_at_most(50) }
  end

  it { is_expected.to have_and_belong_to_many(:books) }
end
