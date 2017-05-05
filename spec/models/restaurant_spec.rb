# require './spec/rails_helper'
require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three charaters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  it { should belong_to(:user) }

  it 'should return average of the reviews' do
    restaurant = Restaurant.new(name: "Moe's Tavern")
    restaurant.reviews.new(rating: 2)
    restaurant.reviews.new(rating: 5)
    restaurant.reviews.new(rating: 4)
    expect(restaurant.average_rating).to eq(3.7)
  end
end
