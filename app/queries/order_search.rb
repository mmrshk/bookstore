class OrderSearch
  def initialize(user, params)
    @params = params
    @orders = user.orders
  end

  def call
    all
    in_queue
    in_delivery
    delivered
    canceled
    @orders
  end

  private

  def all
    @orders = @orders.all_orders if @params['all'].present?
  end

  def in_queue
    @orders = @orders.in_queue if @params['in_queue'].present?
  end

  def in_delivery
    @orders = @orders.in_delivery if @params['in_delivery'].present?
  end

  def delivered
    @orders = @orders.delivered if @params['delivered'].present?
  end

  def canceled
    @orders = @orders.canceled if @params['canceled'].present?
  end
end
