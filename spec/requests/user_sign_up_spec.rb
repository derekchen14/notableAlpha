require 'spec_helper'

describe "User signs up" do
  it "using valid email and password" do
    user = FactoryGirl.build(:user)
    sign_up_with(user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Welcome to Notable! Start creating notes and organizing your thoughts!")
  end
  
  it "using blank email" do
    user = FactoryGirl.build(:user, email: nil)
    sign_up_with(user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Email can't be blank")
  end

  it "using exisiting email" do
    existing_user = FactoryGirl.create(:user)
    new_user = FactoryGirl.build(:user, email: existing_user.email)
    sign_up_with(new_user.email, new_user.password, new_user.password_confirmation)
    expect(page).to have_content("Email has already been taken")
  end
  
  it "using blank password" do
    user = FactoryGirl.build(:user, password: nil)
    sign_up_with(user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Password can't be blank")
  end
  
  it "with password and confirmation mismatch" do
    user = FactoryGirl.build(:user, password_confirmation: "mismatch")
    sign_up_with(user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Password doesn't match confirmation")
  end

  it "with short password" do
    user = FactoryGirl.build(:user, password: "a"*5)
    sign_up_with(user.email,user.password,user.password_confirmation)
    expect(page).to have_content("Password is too short")
  end
end
