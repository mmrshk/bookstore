 class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :set_addresses

  def index; end

  def create
    @address = AddressesService.new(params: address_params, user: current_user).initialize_by_cast

    if @address.save
      flash[:success] = I18n.t('controllers.addresses.address_created')
      redirect_to addresses_path
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_created')
      render :index
    end
  end

  def update
    if address_updated
      flash[:success] = I18n.t('controllers.addresses.address_updated')
      redirect_to addresses_path
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

  def address_updated
    return @address.update(address_params) if address_params[:cast] == 'billing'

    @address.update(address_params)
  end
end
