ActiveAdmin.register Book do
  permit_params :title, :description, :price, :quantity, :category_id, :year, :dimension_d, :dimension_h, :dimension_w, :material

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :description
      f.input :category_id, :label => 'Category', :as => :select, :collection => Category.all.map{|c| ["#{c.title}", c.id]}
      f.input :price
      f.input :quantity
      f.input :year
      f.input :dimension_d
      f.input :dimension_w
      f.input :dimension_h
      f.input :material
      f.input :author_ids, :label => 'Authors', as: :check_boxes, collection: Author.all.map{|a| ["#{a.firstname} #{a.lastname}", a.id]}
    end
    f.actions
  end
end
