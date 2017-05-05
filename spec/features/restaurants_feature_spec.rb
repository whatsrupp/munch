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
      scenario 'does not let you submit a name that is too short' do
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
  context 'updating restaurants' do
    before do
      sign_up
      create_restaurant
    end
    scenario 'user can update a restaurant they have created' do
      click_link 'Edit'
      fill_in 'Description', with: "Wookies"
      click_button 'Update Restaurant'
      expect(page).to have_content 'Wookies'
    end
    scenario 'user cannot update a restaurant when not signed in' do
      click_link 'Sign out'
      click_link "Sign up"
      fill_in 'Email', with: 'alex@alex.com'
      fill_in 'Password', with: 'alexspassword'
      fill_in 'Password confirmation', with: 'alexspassword'
      click_button 'Sign up'
      click_link 'Edit'
      expect(page).to have_content 'You cannot edit this restaurant'
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
    scenario 'user cannot delete a restaurant when not signed in' do
      click_link 'Sign out'
      click_link "Sign up"
      fill_in 'Email', with: 'alex@alex.com'
      fill_in 'Password', with: 'alexspassword'
      fill_in 'Password confirmation', with: 'alexspassword'
      click_button 'Sign up'
      click_link 'Delete'
      expect(page).to have_content 'You cannot delete this restaurant'
    end
  end

  context 'Displaying average rating' do

    context 'reviews left' do
      before do
        sign_up(email: 'naz@whale.com')
        create_restaurant
        click_link 'Sign out'
        sign_up(email: 'hello@hello.com')
        click_link 'Review'
        fill_in('Thoughts', with: 'Not Bad')
        select '5', from: 'Rating'
        click_button('Leave Review')
        click_link 'Sign out'

        sign_up(email: 'hi@hello.com')
        click_link 'Review'
        fill_in('Thoughts', with: 'Not Bad')
        select '3', from: 'Rating'
        click_button('Leave Review')
        click_link 'Sign out'

        sign_up(email: 'yo@hello.com')
        click_link 'Review'
        fill_in('Thoughts', with: 'Not Bad')
        select '3', from: 'Rating'
        click_button('Leave Review')

      end
      scenario 'user can see an average review when looking at the listing on the home page' do
        visit '/restaurants'
        expect(page).to have_content '3.7'
      end

      scenario 'user can see average review when looking at individual listing' do
        visit '/restaurants'
        click_link "KFC"
        expect(page).to have_content '3.7'
      end
    end

    context 'no reviews' do
      scenario 'before any reviews have been made, rating is zero' do
        sign_up
        create_restaurant
        visit '/restaurants'
        expect(page).to have_content '0.0'
      end
    end
  end
end
