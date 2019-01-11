class AddDetailesToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :publish, :boolean, default: false
  end
end
