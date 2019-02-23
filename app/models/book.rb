class Book < ApplicationRecord
  mount_uploaders :images, ImageUploader

  DESCRIPTION_LENGTH_MAX = 2000
  PRICE_LENGTH_MAX = 7
  DESCRIPTION_LENGTH = 250

  has_and_belongs_to_many :authors
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :line_items, dependent: :destroy

  validates :title, :price, :quantity, :dimension_h, :dimension_w, :dimension_d, presence: true
  validates :year, numericality: { less_than_or_equal_to: Time.current.year }
  validates :description, length: { maximum: DESCRIPTION_LENGTH_MAX }
  validates :price, numericality: { only_integer: true }, length: { maximum: PRICE_LENGTH_MAX }

  scope :pop_first, -> { order('created_at DESC') }
  scope :newest, -> { order('created_at DESC') }
  scope :by_title_asc, -> { order('title') }
  scope :by_title_desc, -> { order('title DESC') }
  scope :price_asc, -> { order('price') }
  scope :price_desc, -> { order('price DESC') }
  scope :by_filter, ->(filter) { public_send(filter) }
end
