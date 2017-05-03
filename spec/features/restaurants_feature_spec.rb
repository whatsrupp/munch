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
      Restaurant.create(name: 'Roast and Toast')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Roast and Toast')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Roast and Toast'
      fill_in 'Description', with: 'Delecious'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Roast and Toast'
      expect(current_path).to eq '/restaurants'
    end
  end
  context 'viewing restaurants' do
    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restuarants' do
    before {Restaurant.create name: 'KFC', description: 'Tasty but sick', id: 1 }
    scenario 'let user edit restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Sick but tasty'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Sick but tasty'
      expect(current_path).to eq('/restaurants/1')
    end
  end

  context 'deleting restaurants' do
    before {Restaurant.create name: 'Roasty', description: 'Delicious'}

    scenario 'Removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Roasty'
      expect(page).not_to have_content('Roasty')
      expect(page).to have_content('Restaurant Deleted Successfully')
    end
  end
end
