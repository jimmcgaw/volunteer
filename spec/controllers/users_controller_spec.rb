require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_successful
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign Up")
    end
    
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @invalid_data = {
          :first_name => "",
          :last_name => "",
          :email => "",
          :password => "",
          :password_confirmation => ""
        }
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @invalid_data
        end.should_not change(User, :count)
      end
      
      it "should render the 'new' page" do
        post :create, :user => @invalid_data
        response.should render_template('users/new')
      end
      
      it "should render the error explanation box" do
        post :create, :user => @invalid_data
        response.should have_selector("div#error_explanation")
      end
      
      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Sign Up")
      end
    end
    
    describe "success" do
      
      before(:each) do
        @valid_data = {
          :first_name => "First",
          :last_name => "User",
          :email => "newuser@socapventures.com",
          :password => "foobar",
          :password_confirmation => "foobar"
        }
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @valid_data
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the overview page" do
        post :create, :user => @valid_data
        response.should redirect_to(root_path)
      end
      
      it "should show a welcome message in flash" do
        post :create, :user => @valid_data
        flash[:success].should =~ /thanks for signing up!/i
      end
 
    end
    
  end
  
end
