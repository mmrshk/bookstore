class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :set_addresses

  def index; end

  def create
    if params[:address][:cast] == "billing"
      @billing = current_user.addresses.create(address_params)
      save_address(@billing)
    else
      @shipping = current_user.addresses.create(address_params)
      save_address(@shipping)
    end
  end

  def update
    params[:address][:cast] == "billing" ? update_address(@billing) : update_address(@shipping)
  end

  def save_address(address)
    if address.save
      flash[:success] = I18n.t('controllers.addresses.address_created')
      redirect_to addresses_path
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_created')
      render :index
    end
  end

  def update_address(address)
    if address.update(address_params)
      flash[:success] = I18n.t('controllers.addresses.address_updated')
      redirect_to addresses_path
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_updated')
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(%i[firstname lastname address city zip country phone cast])
  end

  def set_addresses
    @billing = current_user.addresses.billing.first_or_initialize
    @shipping = current_user.addresses.shipping.first_or_initialize
  end
end
