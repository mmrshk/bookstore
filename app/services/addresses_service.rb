class AddressesService
  attr_reader :address_params, :current_user

  def initialize(params:, user: )
    @address_params = params
    @current_user = user
  end

  def initialize_by_cast
    return current_user.addresses.billing.new(address_params) if address_params[:cast] == 'billing'

    current_user.addresses.shipping.new(address_params)
  end
end
