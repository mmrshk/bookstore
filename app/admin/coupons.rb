ActiveAdmin.register Coupon do
  permit_params :coupon, :active, :sale
  DIGITS_COUNT = 10
  RANGE = (1...10).freeze

  form do |f|
    f.inputs 'Coupon' do
      f.input :coupon, input_html: { value: Array.new(DIGITS_COUNT) { rand(RANGE) }.join }
      f.input :active, input_html: { checked: true }
      f.input :sale
    end
    f.actions
  end
end
