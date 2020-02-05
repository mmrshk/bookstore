require 'rails_helper'

RSpec.describe LineItem, type: :model do
  %i[book order].each do |field|
    it { expect(subject).to belong_to(field) }
  end
end
