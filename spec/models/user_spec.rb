require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:addresses).dependent(:destroy) }
  it { should have_many(:orders).dependent(:destroy) }
  it { should have_many(:line_items).through(:orders).dependent(:destroy) }
  it { should have_many(:books).through(:line_items).dependent(:destroy) }
  it { should have_one(:credit_card).dependent(:destroy) }
end
