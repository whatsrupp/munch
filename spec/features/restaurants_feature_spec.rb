require 'rails_helper'

feature 'restaurants' do
  context 'non restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Roast and Toast'
      fill_in 'Description', with: 'Delecious'
      click_button 'Create Restaurant'
    end

    scenario 'display restaurants' do
      expect(page).to have_content('ROAST AND TOAST')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Roast and Toast'
      fill_in 'Description', with: 'Delecious'
      click_button 'Create Restaurant'
      expect(page).to have_content 'ROAST AND TOAST'
      expect(current_path).to eq '/restaurants'
    end
    context 'an invalid restaurant' do
      scenario 'does not let you submit a nane that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end
  context 'viewing restaurants' do

    before do
      sign_up
      create_restaurant
    end
    scenario 'lets a user view a restaurant' do
      kfc = Restaurant.first
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end
  context 'deleting restaurants' do
    before do
      sign_up
      create_restaurant
    end
    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'Displaying average rating' do
    before do
      restaurant = Restaurant.new(name: "Moe's Tavern", description: 'Chboy')
      restaurant.reviews.new(rating: 2)
      restaurant.reviews.new(rating: 5)
      restaurant.reviews.new(rating: 4)
      restaurant.save
    end
    scenario 'user can see an average review when looking at the listing on the home page' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content '3.7'
    end

    scenario 'user can see average review when looking at individual listing' do
      sign_up
      visit '/restaurants'
      click_link "MOE'S TAVERN"
      expect(page).to have_content '3.7'
    end

  end
end
