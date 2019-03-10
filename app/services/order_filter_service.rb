class OrderFilterService
  ORDER_FILTERS = {
    in_queue: I18n.t('models.order.in_queue'),
    in_delivery: I18n.t('models.order.in_delivery'),
    delivered: I18n.t('models.order.delivery'),
    canceled: I18n.t('models.order.canceled'),
    all_orders: I18n.t('models.order.all')
  }.freeze

  class << self
    def key_all
      ORDER_FILTERS.key('All')
    end

    def key_set(order_status)
      ORDER_FILTERS[order_status.to_sym]
    end
  end
end
