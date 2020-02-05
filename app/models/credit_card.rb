class CreditCard < ApplicationRecord
  REGULAR_EXPESSION = {
    name: /\A[a-zA-Z]*\s*[a-zA-Z]*\z/,
    expiration_month_year: /\A((0[1-9])|(1[0-2]))[\/]*((1[5-9])|(2[0-3]))\Z/
  }.freeze

  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, :card_number, :cvv, :expiration_month_year, presence: true
  validates :card_number, length: { is: 16 }
  validates :name, length: { maximum: 50 }
  validates :cvv, length: 3..4
  validates :card_number, :cvv, numericality: { only_integer: true }
  validates :name, format: REGULAR_EXPESSION[:name]
  validates :expiration_month_year, format: REGULAR_EXPESSION[:expiration_month_year]
end
