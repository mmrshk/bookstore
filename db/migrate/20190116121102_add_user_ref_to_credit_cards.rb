class AddUserRefToCreditCards < ActiveRecord::Migration[5.2]
  def change
    add_reference :credit_cards, :user, foreign_key: true 
  end
end
