require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'abilities' do
    subject { ability }

    let(:order) { create(:order) }
    let(:line_item) { create(:line_item) }
    let(:session) { { line_item_ids: [line_item.id] } }

    context 'of authorized user' do
      let(:user) { create(:user) }
      let(:ability) { Ability.new(user, session, order) }

      %i[create read].each do |role|
        it { expect(subject).to be_able_to(role, Review) }
      end

      %i[update destroy].each do |role|
        it { expect(subject).not_to be_able_to(role, Review) }
      end

      %i[create read].each do |role|
        it { expect(subject).to be_able_to(role, LineItem) }
      end

      %i[update destroy].each do |role|
        it { expect(subject).to be_able_to(role, LineItem) }
      end

      %i[create read].each do |role|
        it { expect(subject).to be_able_to(role, Coupon) }
      end

      %i[create read update].each do |role|
        it { expect(subject).to be_able_to(role, Order) }
      end

      %i[create read update].each do |role|
        it { expect(subject).to be_able_to(role, CreditCard) }
      end

      %i[create read update].each do |role|
        it { expect(subject).to be_able_to(role, Address) }
      end

      %i[create read update destroy].each do |role|
        it { expect(subject).to be_able_to(role, User) }
      end

      it { expect(subject).not_to be_able_to(:destroy, Order) }
      it { expect(subject).not_to be_able_to(:destroy, CreditCard) }
      it { expect(subject).not_to be_able_to(:destroy, Address) }
    end

    context 'of not authorized user' do
      let(:user) { User.new }
      let(:ability) { Ability.new(user, session, order) }

      %i[create read].each do |role|
        it { expect(subject).to be_able_to(role, LineItem) }
      end

      %i[create read].each do |role|
        it { expect(subject).to be_able_to(role, Coupon) }
      end

      %i[update destroy].each do |role|
        it { expect(subject).to be_able_to(role, LineItem) }
      end

      it { expect(subject).not_to be_able_to(:read, Order) }
      it { expect(subject).not_to be_able_to(:read, CreditCard) }
      it { expect(subject).not_to be_able_to(:read, Address ) }
    end
  end
end
