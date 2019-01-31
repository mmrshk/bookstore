require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:books).dependent(:destroy) }

  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_length_of(:title).is_at_most(50) }
  # it { should validate_uniqueness_of(:title) }
end
