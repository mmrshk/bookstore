FactoryBot.define do
  factory :order_with_payed_books, parent: :order do |order|
    line_items { build_list :line_item, 10}
  end
end
