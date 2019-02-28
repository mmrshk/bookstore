ActiveAdmin.register Coupon do
  permit_params :coupon, :active, :sale

  form do |f|
    f.inputs I18n.t('admin.coupons.coupon') do
      f.input :coupon, input_html: { value: GenerateCouponService.generate }
      f.input :active, input_html: { checked: true }
      f.input :sale, label: I18n.t('admin.coupons.sale')
    end
    f.actions
  end
end
