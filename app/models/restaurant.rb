class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    total = 0
    unless self.reviews.empty?
      self.reviews.each do |review|
        total += review.rating
      end
      (total.to_f/self.reviews.length).round(1)
    else
      0.0
    end
  end
end
