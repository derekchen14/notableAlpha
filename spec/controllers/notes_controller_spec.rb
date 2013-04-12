require 'spec_helper'
require 'devise'

describe NotesController do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in :user, user 
  end

  describe "POST create" do
    context "with valid note" do
      it "creates a new note" do
        expect{
          post :create, note: FactoryGirl.attributes_for(:note)
        }.to change(Note,:count).by(1)
      end
     
      it "redirects to root_url" do
        post :create, note: FactoryGirl.attributes_for(:note)
        response.should redirect_to root_url
      end
      
      it "creates a blank note" do
        expect{
          post :create, note: FactoryGirl.attributes_for(:note, content: nil)
        }.to change(Note,:count).by(1)
      end
    end
    context "with invalid note" do 
    end
  end

  describe "PUT update" do
    before(:each) do
      @note = FactoryGirl.create(:note, content: "This is my note", user_id: user.id)
    end
    context "with valid content" do
      it "finds the correct note" do
        put :update, id: @note, note: FactoryGirl.attributes_for(:note)
        assigns(:note).should eq(@note)
      end

      it "changes the note's content" do
        put :update, id: @note, 
          note: FactoryGirl.attributes_for(:note, content: "Ipsum Lorem")
        @note.reload
        @note.content.should eq("Ipsum Lorem")
      end

    end
    context "with invalid content" do 
      it "does not change note content" do
        put :update, id: @note, 
          note: FactoryGirl.attributes_for(:note, content: nil)
        @note.reload
        @note.content.should_not eq("Ipsum Lorem")
      end
    end
  end


  describe "DELETE destroy" do
    it "deletes the note" do
      @note = FactoryGirl.create(:note, content: "This is my note", user_id: user.id)
      expect{ delete :destroy, id: @note }.to change(Note,:count).by(-1)
    end
  end

  describe "POST duplicate" do
    it "duplicates a note" do
      @duplicate_note = FactoryGirl.create(:note, content: "Duplicate this", user_id: user.id)
      expect{ post :duplicate, id: @duplicate_note }.to change(Note, :count).by(1)
    end
  end

  describe "GET sort_by" do
    it "responds to js template" do
      get :sort_by, criteria: "created_at (desc)", format: "js"
      response.should render_template("custom_sort")
    end

    it "saves the sort criteria" do
      get :sort_by, criteria: "created_at (desc)", format: :js
      response.cookies["sort_criteria"].should eq("created_at (desc)")
    end
  end

  describe "GET load_tags" do
    it "loads js template file for tags" do
      @note = FactoryGirl.create(:note, user_id: user.id)
      get :load_tags, id: @note, format: :js
      response.should render_template("load_tags")
    end
  end

  describe "POST update_tags" do
    it "responds to the correct template" do
      @note = FactoryGirl.create(:note, user_id: user.id)
      @tags = user.tags
      put :update_tags, id: @note, user_id: user.id, format: :js
      response.should render_template("update_tags")
    end
  end

  describe "GET filter_by_tags" do
    it "renders correct tempate" do
      @tag = FactoryGirl.create(:tag, user_id: user.id)
      get :filter_by_tags, tag: @tag.name, format: :js
      response.should render_template("custom_sort")
    end

    it "filters notes by given tag" do
      @tag = FactoryGirl.create(:tag, user_id: user.id)
      get :filter_by_tags, tag: @tag.name, format: :js
      assigns(:notes).should be_empty
    end
    
  end

  describe "GET note_search" do
    it "renders correct template" do
      get :note_search, format: :js 
      response.should render_template("note_search")
    end

    it "filters notes correctly" do
      get :note_search, query: "click", format: :js
      assigns(:notes).count.should eq(1) 
    end
  end

end
