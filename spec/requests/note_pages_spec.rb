require 'spec_helper'

describe "Notes" do
	subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "note creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a note" do
        expect { click_button "Post" }.not_to change(Note, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'note_content', with: "Lorem ipsum" }
      it "should create a note" do
        expect { click_button "Post" }.to change(Note, :count).by(1)
      end
    end
  end

  describe "note destruction" do
    before { FactoryGirl.create(:note, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a note" do
        expect { click_link "Mark Complete" }.to change(Note, :count).by(-1)
      end
    end
  end
end
