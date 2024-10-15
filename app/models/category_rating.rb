class CategoryRating < ApplicationRecord
  belongs_to :rating
  belongs_to :category

  validates :score, presence: true, numericality: { greater_than: 0, less_than: 6 }
end
