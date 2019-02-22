ActiveAdmin.register Book do
  permit_params :title, :description, :price, :quantity, :category_id, :year, :dimension_d, :dimension_h, :dimension_w,
                :material, images: [], author_ids: []

  form html: { multipart: true } do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :description
      f.input :category_id, label: I18n.t('admin.books.category'), as: :select, collection: Category.all.map { |c| [c.title.to_s, c.id] }
      f.input :price
      f.input :quantity
      f.input :year
      f.input :dimension_d
      f.input :dimension_w
      f.input :dimension_h
      f.input :material
      f.input :author_ids, label: I18n.t('admin.books.authors'), as: :check_boxes,
                           collection: Author.all.map { |a| ["#{a.firstname} #{a.lastname}", a.id] }
      f.file_field :images, multiple: true
    end

    f.actions
  end
end
