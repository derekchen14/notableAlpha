require 'spec_helper'

describe UsersController do

  describe "sign up a NEW user" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "CREATE a new user" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
