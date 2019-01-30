module AddressHelper
  def input_value(cast, field)
    cast == :billing ? @addresses.billing.public_send(field) : @addresses.shipping.public_send(field)
  end
end
