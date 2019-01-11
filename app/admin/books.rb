ActiveAdmin.register Book do
  permit_params :title, :description, :price, :quantity, :category_id, :year, :dimension_d, :dimension_h, :dimension_w, :material


end
