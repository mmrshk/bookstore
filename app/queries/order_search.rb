class OrderSearch
  def initialize(user, params)
    @params = params
    @orders = user.orders
  end

  def call
    @orders.public_send(@params).decorate if @params.present?
  end
end
