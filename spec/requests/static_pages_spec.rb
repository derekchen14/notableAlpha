require 'spec_helper'

describe "Static pages" do

  let(:user) { FactoryGirl.create(:user) }
    
  before(:each) do
    sign_in_with(user.email, user.password)
  end
  
  context "when navigating through user settings" do 
    it "shows notes when Notes is clicked" do
      click_link "account_settings"
      click_link "user_notes"
      expect(page).to have_content("#{user.username}'s Notes")
    end

    it "shows notebooks when Notebooks is clicked" do
      visit root_path
      click_link "account_settings"
      click_link "user_notebooks"
      expect(page).to have_content("All Notebooks")
    end

    it "shows user profile when Profile is clicked" do
      visit root_path
      click_link "account_settings"
      click_link "user_profile"
      expect(page).to have_content("Profile Information")
    end
    
    it "shows the help page when Help is clicked" do
      visit root_path
      click_link "account_settings"
      click_link "help_page"
      expect(page).to have_content("Notable is a web app used for discovering insights through organizing your thoughts and ideas.")
    end
    
    it "shows the settings page when Settings is clicked" do
      visit root_path
      click_link "account_settings"
      click_link "settings_page"
      expect(page).to have_content("Options to personalize your app experience:")
    end

  end
end
