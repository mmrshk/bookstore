class Order < ApplicationRecord
  include AASM
  attr_accessor :active_admin_requested_event

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :credit_card, optional: true

  has_many :line_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :billing, dependent: :destroy
  has_one :shipping, dependent: :destroy

  scope :all_orders, -> { where.not(status: %w[in_progress]).order('created_at DESC') }
  scope :payed, -> { where.not status: %w[in_progress canceled] }

  scope :in_progress, -> { where status: %w[in_progress] }
  scope :in_queue, -> { where status: %w[in_queue] }
  scope :in_delivery, -> { where status: %w[in_delivery] }
  scope :delivered, -> { where status: %w[delivered] }
  scope :canceled, -> { where status: %w[canceled] }

  after_create :set_number

  ORDER_FILTERS = {
    in_queue: 'Waiting for processing',
    in_delivery: 'In delivery',
    delivered: 'Delivery',
    canceled: 'Canceled',
    all: 'All'
  }.freeze

  def set_complete_date
    update(completed_at: Time.current)
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  aasm column: 'status' do
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

  def discount
    return 0 unless coupon

    total_price * coupon.sale / 100
  end

  def total_price_init
    return total_price unless coupon

    total_price - discount
  end

  private

  def set_number
    update(number: 'R' + Time.zone.now.strftime('%Y%m%d'))
  end
end
