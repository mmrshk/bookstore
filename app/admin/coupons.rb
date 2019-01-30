ActiveAdmin.register Coupon do
  permit_params :coupon, :active, :sale

  form do |f|
    f.inputs 'Coupon' do
      f.input :coupon, input_html: { value: Array.new(10) { rand(1...10) }.join }
      f.input :active, input_html: { checked: true }
      f.input :sale
    end
    f.actions
  end
end
