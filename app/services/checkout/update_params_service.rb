class Checkout::UpdateParamsService
  attr_reader :current_order, :session, :checkoutable, :params, :step

  def initialize(order:, step:, session:, params:)
    @current_order = order
    @step = step
    @session = session
    @params = params
    @checkoutable = call_setup_service
  end

  def call
    public_send(@step)
  end
  #
  # def valid?
  #   @valid
  # end

  def addresses
    current_order.update(step: :delivery)
  end

  def delivery
    current_order.update(delivery_id: order_params[:delivery_id], step: :payment)
  end

  def payment
    current_order.update(credit_card_id: checkoutable.id, step: :confirm)
  end

  def confirm
    session[:order_complete] = true
    session[:order_id] = nil
    session[:line_item_ids] = nil
    current_order.coupon&.update(active: false)
    current_order.update(status: OrderFilterService::ORDER_FILTERS.keys.first.to_s, completed_at: Time.current,
                         step: :complete)
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def call_setup_service
    Checkout::SetupService.new(current_order: current_order, step: step, params: params).call
  end
end
