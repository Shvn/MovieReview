class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy

  def score
    return '☆' unless ratings.exists?

    ratings.sum(:score).fdiv(ratings.size).round(2)
  end

  def category_score(category)
    return '☆' unless ratings.exists?

    ratings.sum { |el| el.get_category_score(category) }.fdiv(ratings.size).round(2)
  end
end
