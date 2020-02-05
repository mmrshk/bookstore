class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating, default: 0
      t.text :comment
      t.string :name

      t.timestamps
    end
  end
end
