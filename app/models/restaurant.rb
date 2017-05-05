class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    total = 0
    self.reviews.each do |review|
      total += review.rating
    end
    (total.to_f/self.reviews.length).round(1)
  end
end
