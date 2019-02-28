class AddressesForm
  include ActiveModel::Model

  attr_reader :params, :use_billing, :billing, :shipping,  :user

  def initialize(user, addresses_params = nil)
    @user = user
    @params = addresses_params
    @billing = user.addresses.billing.first_or_initialize
    @shipping = user.addresses.shipping.first_or_initialize
  end

  def save
    save_shipping & save_billing
  end

  private

  def save_billing
    @billing = user.addresses.create(address_params(:billing))
    valid?(@billing)
  end

  def save_shipping
    @shipping = user.addresses.create(address_params(:shipping))
    valid?(@shipping)
  end

  def address_params(type)
    type = use_billing? ? :billing : :shipping
    set_cast
    params.require(type).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end

  def use_billing?
    params[:use_billing].present?
  end

  def set_cast
    if use_billing?
      params[:billing][:cast] = 'shipping'
    end
  end

  def valid?(type)
    return if !type.save

    true
  end
end
