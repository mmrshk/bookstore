class Order < ApplicationRecord
  include AASM
  attr_accessor :active_admin_requested_event

  belongs_to :user,        optional: true
  belongs_to :delivery,    optional: true
  belongs_to :credit_card, optional: true

  has_many :line_items,   dependent: :destroy
  has_many :addresses,    as: :addressable, dependent: :destroy
  has_one  :coupon,       required: false, dependent: :destroy

  scope :all_orders, -> { where.not(status: %w[in_progress]).order('created_at DESC') }
  scope :payed,      -> { where.not status: %w[in_progress canceled] }

  after_create :set_number

  aasm :status, column: :status do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :place_in_queue do
      transitions from: %i[in_progress], to: :in_queue
    end

    event :order_in_delivery do
      transitions from: %i[in_queue], to: :in_delivery
    end

    event :order_delivered do
      transitions from: %i[in_delivery], to: :delivered
    end

    event :canceled do
      transitions from: %i[in_queue in_delivery in_progress delivered], to: :canceled
    end
  end

  aasm :step, column: :step do
    state :addresses, initial: true
    state :delivery
    state :payment
    state :confirm
    state :complete
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def discount
    return 0 unless coupon_id

    total_price * set_coupon.sale / 100
  end

  def total_price_init
    return total_price unless coupon_id

    total_price - discount
  end

  private

  def set_coupon
    @coupon ||= Coupon.find_by(id: coupon_id)
  end

  def set_number
    update(number: 'R' + Time.zone.now.strftime('%Y%m%d%H%M%S'))
  end
end
