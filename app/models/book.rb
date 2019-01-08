class Book < ApplicationRecord
  FILTERS = %i[newest pop_first by_title_asc by_title_desc price_asc price_desc].freeze
  DEFAULT_FILTER = :newest

  belongs_to :category
  has_and_belongs_to_many :authors
  has_many :reviews

  scope :pop_first, -> { order('created_at DESC') }
  scope :newest, -> { order('created_at DESC') }
  scope :by_title_asc, -> { order('title') }
  scope :by_title_desc, -> { order('title DESC') }
  scope :price_asc, -> { order('price') }
  scope :price_desc, -> { order('price DESC') }
  scope :by_filter, ->(filter) { public_send(filter) }
  scope :latest_books, -> { order('created_at DESC').limit(3) }
end
