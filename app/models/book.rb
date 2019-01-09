class Book < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item

  FILTERS = %i[newest pop_first by_title_asc by_title_desc price_asc price_desc].freeze
  DEFAULT_FILTER = :newest
  LATEST_BOOKS_COUNT = 3
  DESCRIPTION_LENGTH_MAX = 2000
  PRICE_LENGTH_MAX = 7

  belongs_to :category
  has_and_belongs_to_many :authors
  has_many :reviews
  has_many :line_items

  validates :title, :price, :quantity, presence: true
  validates :publication_year, numericality: { less_than_or_equal_to: Time.current.year }
  validates :height, :width, :depth, numericality: { greater_than: 0 }
  validates :description, length: { maximum: DESCRIPTION_LENGTH_MAX, too_long: "#{count} characters is the maximum allowed." }
  validates :price, numericality: { only_integer: true }, length: { maximum: PRICE_LENGTH_MAX}

  scope :pop_first, -> { order('created_at DESC') }
  scope :newest, -> { order('created_at DESC') }
  scope :by_title_asc, -> { order('title') }
  scope :by_title_desc, -> { order('title DESC') }
  scope :price_asc, -> { order('price') }
  scope :price_desc, -> { order('price DESC') }
  scope :by_filter, ->(filter) { public_send(filter) }

  scope :latest_books, -> { order('created_at DESC').limit(LATEST_BOOKS_COUNT) }

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line item present")
      throw :abort
    end
  end
end
