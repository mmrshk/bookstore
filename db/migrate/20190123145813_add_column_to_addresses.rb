class AddColumnToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :use_billing, :boolean, default: false
  end
end
