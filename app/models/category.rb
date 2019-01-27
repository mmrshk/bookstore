class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
