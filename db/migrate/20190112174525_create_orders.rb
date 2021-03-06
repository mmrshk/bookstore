class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :total_price, precision:6, scale:2, null:true
      t.string :status
      t.belongs_to :user, index:true
      t.belongs_to :credit_card, foreign_key: true, null:true
      t.string :step

      t.timestamps
    end
  end
end
