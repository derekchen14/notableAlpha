require 'spec_helper'

describe Note do
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:subtitle) }

  it "cannot be created without a user" do
    FactoryGirl.build(:note, user: nil).should_not be_valid
  end

  it "valid without content" do 
    FactoryGirl.build(:note, content: "").should be_valid
  end

  it "invalid without a format" do
    FactoryGirl.build(:note, format: "").should_not be_valid
  end

  it "correctly shortens a note" do
    note = FactoryGirl.build(:note, content: "This is my note to shorten")
    note.shorten.should eq("This is my note to sh...")
  end

  it "valid without subtitle" do
    FactoryGirl.build(:note, subtitle: "").should be_valid
  end
  
end
