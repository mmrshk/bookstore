class SettingsAddressesForm
  include ActiveModel::Model

  attr_reader :billing, :shipping

  def initialize(user)
    @billing = user.addresses.billing.first_or_initialize
    @shipping = user.addresses.shipping.first_or_initialize
  end

  def save
    save_shipping
    save_billing
  end

  def save_billing
    binding.pry
  end

  def save_shipping
  end
end
