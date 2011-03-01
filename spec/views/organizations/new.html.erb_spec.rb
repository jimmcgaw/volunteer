require 'spec_helper'

describe "organizations/new.html.erb" do
  before(:each) do
    assign(:organization, stub_model(Organization,
      :name => "MyString",
      :summary => "MyText",
      :user_id => 1,
      :location_id => 1
    ).as_new_record)
  end

  it "renders new organization form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => organizations_path, :method => "post" do
      assert_select "input#organization_name", :name => "organization[name]"
      assert_select "textarea#organization_summary", :name => "organization[summary]"
      assert_select "input#organization_user_id", :name => "organization[user_id]"
      assert_select "input#organization_location_id", :name => "organization[location_id]"
    end
  end
end
