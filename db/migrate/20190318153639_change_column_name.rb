class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :coupons, :coupon, :code
  end
end
