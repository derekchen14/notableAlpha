require 'spec_helper'

describe Item do
  let(:user) { FactoryGirl.create(:user) }
  before { @note = user.notes.build(content: "Lorem ipsum") }  
  before { @item = @note.items.build(data: "More text") }
  subject { @item }

  it { should respond_to(:data) }
  it { should respond_to(:variable) }
  it { should respond_to(:user_id) }
  
  describe "with blank content" do
    before { @item.data = " " }
    it { should_not be_valid }
  end
  
end