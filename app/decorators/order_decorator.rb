class OrderDecorator < Draper::Decorator
  delegate_all

  def status
    Order::ORDER_FILTERS[object.status.to_sym]
  end
end
