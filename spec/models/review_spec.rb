require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { create(:review, user_id: user.id, book_id: book.id) }

  %i[book user].each do |field|
    it { expect(subject).to belong_to(field) }
  end

  %i[name comment rating].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end

  %i[name comment].each do |field|
    it { expect(subject).to validate_length_of(field) }
  end

  it { expect(subject).to validate_numericality_of(:rating).only_integer }
end
