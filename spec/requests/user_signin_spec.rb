require 'spec_helper'

describe "User Authentication" do

  context "successfully logged in" do
    let(:user) { FactoryGirl.create(:user) }
    
    it "with valid email and password" do
      sign_in_with(user.email, user.password)
      expect(page).to have_content("#{user.username}'s Notes")
    end

    it "with Remember me checked" do 
      fill_in_with(user.email, user.password)
      check "Remember Me"
      click_button "Sign in"
      expect(page).to have_content("#{user.username}'s Notes")
    end
  end

  context "invalid login" do

    it "when password is blank" do
      user = FactoryGirl.build(:user, password: nil)
      sign_in_with(user.email, user.password)
      expect(page).to have_content("Invalid email or password")
    end

    it "when email is blank" do
      user = FactoryGirl.build(:user, email: nil)
      sign_in_with(user.email, user.password)
      expect(page).to have_content("Invalid email or password")
    end

    it "when email and password do not match" do
      user = FactoryGirl.create(:user)
      invalid_user = FactoryGirl.build(:user, password: "secret")
      sign_in_with(user.email, invalid_user.password)
      expect(page).to have_content("Invalid email or password")
    end
  end

  it "successfully logged out" do
    user = FactoryGirl.create(:user)
    sign_in_with(user.email, user.password)
    click_link "Account"
    click_link "Sign out"
    expect(page).to have_content("Welcome to Notable")
  end
end
