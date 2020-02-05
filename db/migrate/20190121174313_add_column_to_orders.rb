class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :completed_at, :timestamp
  end
end
