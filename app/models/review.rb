class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  NAME_MAX_LENGTH = 80
  COMMENT_MAX_LENGTH = 500
  RATING = {
    min: 0,
    max: 5
  }

  scope :published, -> { where(publish: true) }
  scope :unpublished, -> { where(publish: false) }

  validates :name, :comment, :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_then: RATING[:min], less_than_or_equal_to: RATING[:max] }

  validates :name, length: { maximum: NAME_MAX_LENGTH }
  validates :comment, length: { maximum: COMMENT_MAX_LENGTH }
end
