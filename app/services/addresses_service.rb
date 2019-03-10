class AddressesService
  class << self
    def set_save_flash(address, flash)
      return flash[:success] = I18n.t('controllers.addresses.address_created') if address.errors.none?

      flash[:danger] = I18n.t('controllers.addresses.address_not_created')
    end

    def set_update_flash(address, flash, address_params)
      return flash[:success] = I18n.t('controllers.addresses.address_updated') if address.update(address_params)

      flash[:danger] = I18n.t('controllers.addresses.address_not_updated')
    end
  end
end
