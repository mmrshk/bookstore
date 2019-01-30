ActiveAdmin.register Order do
  permit_params :active_admin_requested_event, :number, :total_price, :status, :user_id, :credit_card_id, :credit_card_id, :delivery_id, :use_billing, :completed_at

  scope :all_orders
  scope :in_progress
  scope :in_queue
  scope :in_delivery
  scope :delivered
  scope :canceled

  after_save do |order|
   event = params[:order][:active_admin_requested_event]
   unless event.blank?
     safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
     raise "Forbidden event #{event} requested on instance #{order.id}" unless safe_event
     order.send("#{safe_event}!")
   end
 end

 form do |f|
   f.input :status, input_html: { disabled: true }, label: 'Current state'
   f.input :active_admin_requested_event, label: 'Change state', as: :select, collection: f.object.aasm.events(permitted: true).map(&:name)
   f.actions
 end
end
