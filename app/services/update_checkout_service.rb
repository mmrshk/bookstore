class UpdateCheckoutService
  attr_reader :user, :order, :session

  def initialize(current_user, current_order, step, session, params)
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
    AddressesForm.new(order, addresses_params)
  end

  def delivery
    Delivery.all
  end

  def payment
    CreditCard.new(credit_card_params)
  end

  def confirm; end

  private

  def addresses_params
    @params.require(:addresses_form)
  end

  def credit_card_params
    @params.require(:credit_card).permit(:card_number, :name, :expiration_month_year, :cvv)
  end
end
