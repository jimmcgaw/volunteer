require 'spec_helper'

describe "events/new.html.erb" do
  before(:each) do
    assign(:event, stub_model(Event,
      :name => "MyString",
      :summary => "MyText",
      :additional => "MyText",
      :show_organization => false,
      :show_coordinators => false,
      :organization_id => 1,
      :location_id => 1
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_name", :name => "event[name]"
      assert_select "textarea#event_summary", :name => "event[summary]"
      assert_select "textarea#event_additional", :name => "event[additional]"
      assert_select "input#event_show_organization", :name => "event[show_organization]"
      assert_select "input#event_show_coordinators", :name => "event[show_coordinators]"
      assert_select "input#event_organization_id", :name => "event[organization_id]"
      assert_select "input#event_location_id", :name => "event[location_id]"
    end
  end
end
