class OrderPresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
  end

  def address
    @model.cast.capitalize
  end

  def username
    "#{@model.firstname} #{@model.lastname}"
  end

  def city_zip
    "#{@model.city} #{@model.zip}"
  end

  def complete_username
    "#{@model.addresses.first.firstname} #{@model.addresses.first.lastname}"
  end

  def complete_city_zip
    "#{@model.addresses.first.city} #{@model.addresses.first.zip}"
  end

  def card_number
    @model.credit_card.card_number.last(4)
  end

  def description
    @model.book.description.split('.').first
  end

  def completed_date
    @model.orders.last.completed_at.strftime('%B %-d, %Y')
  end

  def show_order_date
    @model.completed_at.strftime('%Y-%m-%d')
  end

  def billing_username
    "#{@model.addresses.billing.first.firstname} #{@model.addresses.billing.first.lastname}"
  end

  def billing_zip_city
    "#{@model.addresses.billing.first.city} #{@model.addresses.billing.first.zip}"
  end

  def shipping_username
    "#{@model.addresses.shipping.first.firstname} #{@model.addresses.shipping.first.lastname}"
  end

  def shipping_zip_city
    "#{@model.addresses.shipping.first.city} #{@model.addresses.shipping.first.zip}"
  end

  private

  def method_missing(*args, &block)
    @model.public_send(*args, &block)
  end
end
