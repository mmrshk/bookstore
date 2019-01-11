class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :published, -> { where.not(publish: false) }
  scope :unpublished, -> { where(publish: false) }
end
