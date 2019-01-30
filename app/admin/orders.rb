ActiveAdmin.register Order do
  permit_params :number, :total_price, :status, :user_id, :credit_card_id, :coupon_id, :delivery_id, :use_billing, :completed_at
end
