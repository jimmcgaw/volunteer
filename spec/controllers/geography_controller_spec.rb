require 'spec_helper'

describe GeographyController do

  describe "GET 'map'" do
    it "should be successful" do
      get 'map'
      response.should be_success
    end
  end

end
