class Category < ApplicationRecord
  has_many :category_ratings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
