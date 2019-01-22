class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :credit_card, optional: true

  has_many :line_items, dependent: :destroy
  has_many :addresses, as: :addressable

  enum status: %i[in_progress in_queue in_delivery delivered canceled]

  scope :all_orders, -> { where.not(status: %w[in_progress]).order('created_at DESC') }

  after_create :set_number_and_status

  def place_in_queue
    update(status: 1, completed_at: Time.current)
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  private

  def set_number_and_status
    update(number: 'R'+Time.now.strftime("%Y%m%d"), status: 0)
  end
end
