require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to have_many(:orders).dependent(:destroy) }

  %i[name card_number cvv expiration_month_year].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end

  it { expect(subject).to validate_length_of(:card_number).is_equal_to(16) }
  it { expect(subject).to validate_length_of(:name).is_at_most(50) }

  it { expect(subject).to validate_numericality_of(:card_number).only_integer }
  it { expect(subject).to validate_numericality_of(:cvv).only_integer }

  it { expect(subject).to allow_value('01/20').for(:expiration_month_year) }
  it { expect(subject).to allow_value('06/20').for(:expiration_month_year) }

  it { expect(subject).to_not allow_value('14/20').for(:expiration_month_year) }
  it { expect(subject).not_to allow_value('00/20').for(:expiration_month_year) }
  it { expect(subject).not_to allow_value('/19').for(:expiration_month_year) }
  it { expect(subject).not_to allow_value('01/').for(:expiration_month_year) }
  it { expect(subject).not_to allow_value('14/').for(:expiration_month_year) }
  it { expect(subject).not_to allow_value('/').for(:expiration_month_year) }
  it { expect(subject).not_to allow_value('ab/bb').for(:expiration_month_year) }

  it { expect(subject).to allow_value('1111222233334444').for(:card_number) }

  it { expect(subject).not_to allow_value('a' * 16).for(:card_number) }
  it { expect(subject).not_to allow_value('2131232').for(:card_number) }
  it { expect(subject).not_to allow_value('dsff3424d').for(:card_number) }

  it { expect(subject).to allow_value('Dima Bavykin').for(:name) }
  it { expect(subject).not_to allow_value(' ').for(:name) }
  it { expect(subject).not_to allow_value('!@#$%^&*_+').for(:name) }
end
