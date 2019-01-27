class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :credit_card, optional: true

  has_many :line_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :billing, dependent: :destroy
  has_one :shipping, dependent: :destroy

  enum status: %i[in_progress in_queue in_delivery delivered canceled]

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

  private

  def set_number_and_status
    update(number: 'R' + Time.now.strftime('%Y%m%d'), status: 0)
  end
end
