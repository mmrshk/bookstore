class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :set_addresses

  def index; end

  def create
    if params[:address][:cast] == 'billing'
      @billing = current_user.addresses.create(address_params)
      AddressesService.set_save_flash(@billing, flash)
    else
      @shipping = current_user.addresses.create(address_params)
      AddressesService.set_save_flash(@shipping, flash)
    end

    render :index
  end

  def update
    if params[:address][:cast] == 'billing'
      AddressesService.set_update_flash(@billing, flash, address_params)
    else
      AddressesService.set_update_flash(@shipping, flash, address_params)
    end

    render :index
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast,
                                    :addressable_type, :addressable_id)
  end

  def set_addresses
    @billing = current_user.addresses.billing.first_or_initialize
    @shipping = current_user.addresses.shipping.first_or_initialize
  end
end
