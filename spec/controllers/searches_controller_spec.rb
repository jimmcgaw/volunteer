require 'spec_helper'

describe SearchesController do

  describe "GET 'results'" do
    it "should be successful" do
      get 'results'
      response.should be_success
    end
  end

end
