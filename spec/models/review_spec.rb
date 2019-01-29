require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { create(:review, user_id: user.id, book_id: book.id) }

  it { should belong_to(:book)}
  it { should belong_to(:user)}

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:comment) }
  it { expect(subject).to validate_presence_of(:rating) }
  it { expect(subject).to validate_numericality_of(:rating).only_integer }
  it { expect(subject).to validate_length_of :name }
  it { expect(subject).to validate_length_of :comment }
end
