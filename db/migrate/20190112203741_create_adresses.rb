class CreateAdresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :firstname, null:false
      t.string :lastname, null:false
      t.string :address, null:false
      t.string :city, null:false
      t.string :zip, null:false
      t.string :country, null:false
      t.string :phone, null:false
      t.integer :cast, null:false
  
      t.timestamps
    end
  end
end
