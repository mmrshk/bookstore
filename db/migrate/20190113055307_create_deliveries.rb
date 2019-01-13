class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :name, null:false
      t.string :time, null:false
      t.decimal :price, null:false
      
      t.timestamps
    end
  end
end
