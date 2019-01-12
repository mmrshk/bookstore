class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :card_numder, null:false
      t.string :name, null:false
      t.integer :cvv, null: false
      t.integer :expiration_month, null: false
      t.integer :expiration_year, null: false
      t.timestamps
    end
  end
end
