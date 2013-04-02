require 'spec_helper'

describe "User profie update" do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in_with(user.email, user.password)
    visit edit_user_registration_path
  end

  context "update fails when" do
    it "username is blank" do
      fill_in "Username", with: nil
      click_button "Save changes"
      expect(page).to have_content("Username can't be blank")
    end

    it "email is blank" do 
      fill_in "Email", with: ""
      click_button "Save changes"
      expect(page).to have_content("Email can't be blank")
    end
    
    it "phone number is invalid" do 
      fill_in "Phone Number", with: 123092384023984023984
      click_button "Save changes"
      expect(page).to have_content("Phone number is too long")
    end
    
    it "passwords do not match" do 
      fill_in "Password", with: "abc1234"
      fill_in :password_confirmation, with: "xyz1234"
      click_button "Save changes"
      expect(page).to have_content("Password doesn't match confirmation")
    end
  end
    
    it "Add, Edit, Delete phone number" do
      fill_in "Phone Number", with: 6503472313 
      click_button "Save changes"
      expect(page).to have_content("Phone number successfully added")
      visit edit_user_registration_path
      fill_in "Phone Number", with: 6503472311 
      click_button "Save changes"
      expect(page).to have_content("Phone number successfully updated")
      visit edit_user_registration_path
      fill_in "Phone Number", with: nil
      click_button "Save changes"
      expect(page).to have_content("Phone number successfully removed")
    end

end

