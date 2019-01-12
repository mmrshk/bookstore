class Order < ApplicationRecord
  has_one :user
  has_one :credit_card
end
