class AddressesForm
  USE_BILLING_CHECKED = '1'.freeze

  include ActiveModel::Model

  attr_reader :params, :use_billing, :billing, :shipping, :order, :user

  def initialize(user, order, addresses_params = nil)
    @user = user
    @order = order
    @params = addresses_params
    @billing = set_billing
    @shipping = set_shipping
  end

  def save
    save_billing & save_shipping
  end

  private

  def save_billing
    if order.addresses.billing.exists?
      @billing = order.addresses.billing.first
      @billing.update(address_params(:billing))
    else
      @billing = order.addresses.billing.first_or_initialize(address_params(:billing))
      @billing.save
    end
  end

  def save_shipping
    if order.addresses.shipping.exists?
      @shipping = order.addresses.shipping.first
      @shipping.update(set_address_cast(address_params(type)))
    else
      @shipping = order.addresses.shipping.first_or_initialize(set_address_cast(address_params(type)))
      @shipping.save
    end
  end

  def set_billing
    return user.addresses.billing.first_or_initialize if order.addresses.billing.none?

    order.addresses.billing.first_or_initialize
  end

  def set_shipping
    return user.addresses.shipping.first_or_initialize if order.addresses.shipping.none?

    order.addresses.shipping.first_or_initialize
  end

  def set_address_cast(params)
    params[:cast] = 'shipping' if use_billing?

    params
  end

  def address_params(type)
    params.require(type).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end

  def use_billing?
    params[:use_billing].eql?(USE_BILLING_CHECKED)
  end

  def type
    use_billing? ? :billing : :shipping
  end
end
