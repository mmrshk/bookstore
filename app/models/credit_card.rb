class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :name, :card_numder, :cvv, :expiration_month_year, presence: true
  validates :card_numder, length: { is: 16 }
  validates :name, length: { maximum: 50 }
  validates :cvv, length:3..4
  validates :card_numder, :cvv, numericality: { only_integer: true }

  # CHANGE IT
  validates :name, format: /\A[a-zA-Z]*\s*[a-zA-Z]*\z/
  validates :expiration_month_year, format: /\A(0[1-9]|10|11|12)\/\d\d\z/

end
