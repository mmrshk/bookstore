class AddDetailsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :year, :integer
    add_column :books, :dimension_h, :decimal, precision: 5, scale: 2
    add_column :books, :dimension_w, :decimal, precision: 5, scale: 2
    add_column :books, :dimension_d, :decimal, precision: 5, scale: 2
    add_column :books, :material, :string
  end
end
