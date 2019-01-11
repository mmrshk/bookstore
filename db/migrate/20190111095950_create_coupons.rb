class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :coupon, unique: true, null: false
      t.boolean :active, default: false
      t.decimal :sale, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end
