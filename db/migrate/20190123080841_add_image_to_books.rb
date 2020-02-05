class AddImageToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :images, :string, array: true, default: [] 
  end
end
