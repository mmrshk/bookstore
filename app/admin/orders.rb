ActiveAdmin.register Order do
  permit_params :active_admin_requested_event, :number, :total_price, :status, :user_id, :credit_card_id,
                :credit_card_id, :delivery_id, :use_billing, :completed_at

  scope :all_orders
  scope :in_progress
  scope :in_queue
  scope :in_delivery
  scope :delivered
  scope :canceled

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    if event.present?
      safe_event = (order.aasm(:status).events(permitted: true).map(&:name) & [event.to_sym]).first
      raise I18n.t('admin.orders.error', event: event, order: order.id) unless safe_event

      order.public_send(I18n.t('admin.orders.safe_event', safe_event: safe_event))
    end
  end

  form do |f|
    f.input :status, input_html: { disabled: true }, label: I18n.t('admin.orders.current_state')
    f.input :active_admin_requested_event, label: I18n.t('admin.orders.change_state'), as: :select,
                                           collection: f.object.aasm(:status).events(permitted: true).map(&:name)
    f.actions
  end
end
