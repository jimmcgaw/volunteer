require 'spec_helper'

describe "events/index.html.erb" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :name => "Name",
        :summary => "MyText",
        :additional => "MyText",
        :show_organization => false,
        :show_coordinators => false,
        :organization_id => 1,
        :location_id => 1
      ),
      stub_model(Event,
        :name => "Name",
        :summary => "MyText",
        :additional => "MyText",
        :show_organization => false,
        :show_coordinators => false,
        :organization_id => 1,
        :location_id => 1
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
