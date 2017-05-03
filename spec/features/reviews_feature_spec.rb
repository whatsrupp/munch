require 'rails_helper'

feature 'reviewing' do
  before 'create restaurant entry' do
    Restaurant.create name: 'Fast Falafz'
  end
  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Fast Falafz'
    fill_in 'Thoughts', with: 'Pretty fast'
    select '4', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Pretty fast')
  end
end
