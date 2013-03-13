require 'spec_helper'

describe User do

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:sendhub_id) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:current_password) }
  it { should respond_to(:admin) }
  it { should respond_to(:notes) }


  it  "invalid when username is blank" do 
    FactoryGirl.build(:user, username: "").should_not be_valid 
  end

  it "username cannot be too long" do
    FactoryGirl.build(:user, username: "a"*51).should_not be_valid
  end
  
  it "invalid when email is blank" do
    FactoryGirl.build(:user, email: "").should_not be_valid
  end
  
  it "email address must be unique" do 
    existing_user = FactoryGirl.create(:user, email: "test@email.com")
    FactoryGirl.build(:user, email: existing_user.email).should_not be_valid
  end

  it "invalid when password is blank" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it "invalid when password confirmation is blank" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it "password and confirmation must match" do
    FactoryGirl.build(:user, password_confirmation: "mismatch").should_not be_valid
  end

  it "cannot have a short password" do
    FactoryGirl.build(:user, password:"a"*5) 
  end

end
