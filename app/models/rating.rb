class Rating < ApplicationRecord
  before_save :calculate_score

  LEVEL = 1..5
  CATEGORY = { performance: 0, special_effects: 1, storytelling: 2 }.freeze

  belongs_to :movie

  validate :categories_exists

  def set_category_score(type, score)
    raise ArgumentError, 'Invalid rating category' unless CATEGORY.key?(type.to_sym)

    raise ArgumentError, 'Invalid rating score' if score.to_i < 1 || score.to_i > 5

    categories[Rating::CATEGORY[type.to_sym]] = score
  end

  def get_category_type(score)
    CATEGORY.key(score.to_i).to_s.humanize.titleize
  end

  def get_category_score(type)
    categories[Rating::CATEGORY[type.to_sym].to_s].to_i
  end

  private
    def calculate_score
      self.score = categories.values.sum(&:to_i).fdiv(categories.size)
    end

    def categories_exists
      return if (categories.keys <=> Rating::CATEGORY.values).zero?

      errors.add(:base, 'Invalid rating')
    end
end
