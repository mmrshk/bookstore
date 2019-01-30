class Order < ApplicationRecord
  include AASM

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

  after_create :set_number_and_status

  ORDER_FILTERS = {
    in_queue: 'Waiting for processing',
    in_delivery: 'In delivery',
    delivered: 'Delivery',
    canceled: 'Canceled',
    all: 'All'
  }.freeze

  def place_in_queue
    update(status: 1, completed_at: Time.current)
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  enum status: %i[in_progress in_queue in_delivery delivered canceled]

  aasm(:status) do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :order_in_queue do
      transitions in_progress: :in_queue
    end

    event :order_in_delivery do
      transitions in_queue: :in_delivery
    end

    event :order_delivered do
      transitions in_delivery: :delivered
    end

    event :canceled do
      transitions from: [:in_queue, :in_delivery], to: :canceled
    end

  end

  private

  def set_number_and_status
    update(number: 'R' + Time.now.strftime('%Y%m%d'), status: 0)
  end
end
