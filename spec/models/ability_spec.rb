require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe "abilities of loggined user" do
    subject { ability }

    let(:ability){ Ability.new(user) }
    let(:user){ FactoryBot.create(:user) }
    let(:review){ FactoryBot.create(:review) }

    context 'for posts' do
      # it { expect(ability).to be_able_to(:create, Review) }
      # it { expect(ability).not_to be_able_to(:update, review) }
      # it { expect(ability).not_to be_able_to(:destroy, review) }
    end
  end
end
