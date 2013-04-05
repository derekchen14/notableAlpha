require 'spec_helper'

describe Note do
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it "cannot be created without a user" do
    FactoryGirl.build(:note, user: nil).should_not be_valid
  end

  it "valid without content" do 
    FactoryGirl.build(:note, content: "").should be_valid
  end

  it "invalid without a format" do
    FactoryGirl.build(:note, format: "").should_not be_valid
  end
  
end
