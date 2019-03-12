class OrderFilterService
  ORDER_FILTERS = {
    in_queue: I18n.t('models.order.in_queue'),
    in_delivery: I18n.t('models.order.in_delivery'),
    delivered: I18n.t('models.order.delivery'),
    canceled: I18n.t('models.order.canceled'),
    all_orders: I18n.t('models.order.all')
  }.freeze

  attr_reader :order_status

  def initialize(params)
    @order_status = params[:order_status] || key_all
  end

  def set_active_filter
    order_status ? key_set : key_all
  end

  def key_all
    ORDER_FILTERS.key('All')
  end

  def key_set
    ORDER_FILTERS[order_status.to_sym]
  end
end
