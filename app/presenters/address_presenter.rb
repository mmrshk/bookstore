class AddressPresenter < SimpleDelegator

  def initialize(model, view)
    @model = model
    @view = view
  end

  def input_value(cast, field)
    cast == :billing ? billing.public_send(field) : shipping.public_send(field)
  end

  private

  def method_missing(*args, &block)
    @model.send(*args, &block)
  end
end
