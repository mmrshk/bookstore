require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to_not validate_presence_of(:active) }
  it { expect(subject).to validate_length_of(:coupon).is_equal_to(10) }
  # .allow_blank
end
