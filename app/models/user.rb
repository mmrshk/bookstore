class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_many :addresses, as: :addressable

end
