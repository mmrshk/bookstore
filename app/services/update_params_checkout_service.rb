class UpdateParamsCheckoutService
  attr_reader :current_order, :session, :credit_card

  def initialize(current_order, step, session, credit_card, params)
    @current_order = current_order
    @step = step
    @session = session
    @credit_card = credit_card
    @params = params
  end

  def call
    public_send(@step)
  end

  def addresses
    current_order.update(step: :delivery)
  end

  def delivery
    current_order.update(delivery_id: order_params[:delivery_id], step: :payment)
  end

  def payment
    current_order.update(credit_card_id: credit_card.id, step: :confirm)
  end

  def confirm
    current_order.update(status: OrderFilterService::ORDER_FILTERS.keys.first.to_s, completed_at: Time.current, step: :complete)
    current_order.coupon.update(active: false) if current_order.coupon
    session[:order_complete] = true
    session[:order_id] = nil
    session[:line_item_ids] = nil
    session[:coupon_id] = nil
  end

  private

  def order_params
    @params.require(:order).permit(:delivery_id)
  end
end
