class Checkout::UpdateService
  attr_reader :user, :order, :session, :params

  def initialize(current_user:, current_order:, step:, session:, params:)
    @user = current_user
    @order = current_order
    @step = step
    @session = session
    @params = params
  end

  def call
    public_send(@step)
  end

  def addresses
    set_order_use_billing
    AddressesForm.new(user, order, addresses_params)
  end

  def delivery
    Delivery.all
  end

  def payment
    CreditCard.new(credit_card_params)
  end

  def confirm; end

  private

  def set_order_use_billing
    order.update(use_billing: use_billing?)
  end

  def use_billing?
    addresses_params[:use_billing].eql?(AddressesForm::USE_BILLING_CHECKED)
  end

  def addresses_params
    @params.require(:addresses_form).permit(
      { billing: [:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast] },
      { shipping: [:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast] }, :use_billing)
  end

  def credit_card_params
    @params.require(:credit_card).permit(:card_number, :name, :expiration_month_year, :cvv)
  end
end
