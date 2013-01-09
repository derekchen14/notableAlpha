require 'spec_helper'

describe Note do
  let(:user) { FactoryGirl.create(:user) }
  before { @note = user.notes.build(content: "Lorem ipsum") }  
  subject { @note }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @note.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Note.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @note.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @note.content = " " }
    it { should_not be_valid }
  end
  
end