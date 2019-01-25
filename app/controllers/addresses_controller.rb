class AddressesController < ApplicationController
  load_and_authorize_resource

  def create
    current_user.addresses.create(address_params)

    redirect_to edit_user_registration_path
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)

    redirect_to edit_user_registration_path
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end
end
