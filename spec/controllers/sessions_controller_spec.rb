require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Login")
    end
  end
  
  describe "POST 'create'" do
    describe "invalid login" do
      before(:each) do
        @invalid_data = { 
          :email => "email@example.com", 
          :password => "invalid"
        }
      end
      
      it "should re-render the new page" do
        post :create, :session => @invalid_data
        response.should render_template("new")
      end
      
      it "should have the right title" do
        post :create, :session => @invalid_data
        response.should have_selector("title", :content => "Login")
      end
      
      it "should have a flash.now message" do
        post :create, :session => @invalid_data
        flash.now[:error].should =~ /invalid/i
      end
    end
    
    describe "with valid email and password" do
      before(:each) do
        @user = Factory(:user)
        @valid_data = {
          :email => @user.email,
          :password => @user.password
        }
      end
      
      it "should sign the user in" do
        post :create, :session => @valid_data
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it "should redirect to the overview page" do
        post :create, :session => @valid_data
        response.should redirect_to(root_path)
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    
    it "should sign a user out" do 
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
    
  end
 

end
