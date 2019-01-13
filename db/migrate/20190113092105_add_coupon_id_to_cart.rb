class AddCouponIdToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :coupon, index: true, null: true
  end
end
