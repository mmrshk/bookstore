class OrderSearch
  def initialize(user, params)
    @params = params
    @orders = user.orders
  end

  def call
    filter
    @orders
  end

  private

  def filter
    @orders = @orders.public_send(@params) if @params.present?
  end
end
