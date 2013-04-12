require 'spec_helper'
require 'devise'

describe SidebarController do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in :user, user 
  end
  
  describe "GET short_notes" do
    it "has a 200 status code" do
      get :short_notes
      response.code.should eq("200")
    end
    
    it "renders correct template" do
      get :short_notes
      response.should render_template(:short_notes)
    end
  end

  describe "GET recent_notes" do
    it "has a 200 status code" do
      get :recent_notes
      response.code.should eq("200")
    end

    it "renders correct template" do
      get :recent_notes
      response.should render_template(:short_notes)
    end
  end

  describe "GET select_note" do
    before(:each) do
      @note = FactoryGirl.create(:note, user_id: user.id)
    end
    it "has a 200 status code" do
      get :select_note, id: @note, format: :js
      response.code.should eq("200")
    end

    it "render correct template" do
      get :select_note, id: @note, format: :js
      response.should render_template(:select_note)
    end
  end
end
