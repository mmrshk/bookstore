class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision:6, scale:2, null:false
      t.string :status, default: 'processing'
      t.belongs_to :user, index:true
      t.belongs_to :credit_card, index:true

      t.timestamps
    end
  end
end
