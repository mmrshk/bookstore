class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reviews
  has_many :orders
  has_many :credit_cards


end
