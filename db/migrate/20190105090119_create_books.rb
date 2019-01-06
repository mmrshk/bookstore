class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :price, precision: 5, scale: 2, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
