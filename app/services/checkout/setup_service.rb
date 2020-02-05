class Checkout::SetupService
  attr_reader :user, :order, :params, :step

  def initialize(current_order:, step:, params:)
    @order = current_order
    @user = current_order.user
    @step = step
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
    order.update(use_billing: addresses_params[:use_billing])
  end

  def addresses_params
    @params.require(:addresses_form).permit(
      { billing: %i[firstname lastname address city zip country phone cast] },
      { shipping: %i[firstname lastname address city zip country phone cast] }, :use_billing)
  end

  def credit_card_params
    @params.require(:credit_card).permit(:card_number, :name, :expiration_month_year, :cvv)
  end
end
