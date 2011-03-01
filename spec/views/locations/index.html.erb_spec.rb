require 'spec_helper'

describe "locations/index.html.erb" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :name => "Name",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :postal_code => "Postal Code",
        :phone_number => "Phone Number",
        :latitude => "9.99",
        :longitude => "9.99",
        :user_id => 1
      ),
      stub_model(Location,
        :name => "Name",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :postal_code => "Postal Code",
        :phone_number => "Phone Number",
        :latitude => "9.99",
        :longitude => "9.99",
        :user_id => 1
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
