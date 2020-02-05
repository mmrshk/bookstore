class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :set_addresses

  def index; end

  def create
    if @address.save
      redirect_to addresses_path, success: I18n.t('controllers.addresses.address_created')
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_created')
      render :index
    end
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, success: I18n.t('controllers.addresses.address_updated')
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_updated')
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end

  def set_addresses
    @addresses = current_user.addresses
  end
end
