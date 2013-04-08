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
end
