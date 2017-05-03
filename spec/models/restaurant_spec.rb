require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three charaters' do
  restaurant = Restaurant.new(name: 'kf')
  expect(restaurant).not_to be_valid
  end
end
