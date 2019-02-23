class AddressesController < ApplicationController
  load_and_authorize_resource

  def create
    current_user.addresses.create(address_params)

    redirect_to edit_user_registration_path
  end

  def update
    if @address.update(address_params)
      flash[:success] = I18n.t('controllers.addresses.address_updated')
      redirect_to edit_user_registration_path
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_updated')
      # render 'devise/registrations/edit'
    end
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end
end
