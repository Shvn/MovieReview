class Rating < ApplicationRecord
  belongs_to :movie
  has_many :category_ratings, dependent: :destroy

  accepts_nested_attributes_for :category_ratings

  scope :order_desc, -> { order(created_at: :desc, id: :desc) }

  def self.included_resources
    includes(category_ratings: :category)
  end

  def average_score
    category_ratings.average(:score).round(2)
  end
end
