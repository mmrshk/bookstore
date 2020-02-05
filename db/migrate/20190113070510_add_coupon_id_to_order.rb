class AddCouponIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :coupon, index: true, null: true
  end
end
