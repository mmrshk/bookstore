class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, :card_number, :cvv, :expiration_month_year, presence: true
  validates :card_number, length: { is: 16 }
  validates :name, length: { maximum: 50 }
  validates :cvv, length: 3..4
  validates :card_number, :cvv, numericality: { only_integer: true }
  validates :name, format: /\A[a-zA-Z]*\s*[a-zA-Z]*\z/
  validates :expiration_month_year, format: /\A(0[1-9]|10|11|12)\/\d\d\z/
end
