require 'spec_helper'

describe "locations/edit.html.erb" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :name => "MyString",
      :address1 => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :postal_code => "MyString",
      :phone_number => "MyString",
      :latitude => "9.99",
      :longitude => "9.99",
      :user_id => 1
    ))
  end

  it "renders the edit location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => locations_path(@location), :method => "post" do
      assert_select "input#location_name", :name => "location[name]"
      assert_select "input#location_address1", :name => "location[address1]"
      assert_select "input#location_address2", :name => "location[address2]"
      assert_select "input#location_city", :name => "location[city]"
      assert_select "input#location_state", :name => "location[state]"
      assert_select "input#location_postal_code", :name => "location[postal_code]"
      assert_select "input#location_phone_number", :name => "location[phone_number]"
      assert_select "input#location_latitude", :name => "location[latitude]"
      assert_select "input#location_longitude", :name => "location[longitude]"
      assert_select "input#location_user_id", :name => "location[user_id]"
    end
  end
end
