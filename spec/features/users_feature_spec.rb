require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end
    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end
    it "should not see a 'sign in' link link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
  context "User attempts to list restaurant without logging in" do
    it "should throw error when attempting to list restaurant" do
      visit ('/restaurants')
      click_link 'Add a restaurant'
      fill_in('Name', with: 'Roast and toast')
      expect 
    end
  end
end
