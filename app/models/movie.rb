class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :category_ratings, through: :ratings

  def overall_score
    return '☆' unless category_ratings.exists?

    category_ratings.average(:score).round(2)
  end

  def category_score
    return unless category_ratings.exists?

    category_ratings
      .joins(:category).group('categories.name').average(:score)
      .transform_values { |v| v.round(2) }
  end
end
