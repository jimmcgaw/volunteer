require 'spec_helper'

describe "shifts/index.html.erb" do
  before(:each) do
    assign(:shifts, [
      stub_model(Shift,
        :title => "Title",
        :description => "MyText",
        :event_id => 1,
        :volunteer_count => 1
      ),
      stub_model(Shift,
        :title => "Title",
        :description => "MyText",
        :event_id => 1,
        :volunteer_count => 1
      )
    ])
  end

  it "renders a list of shifts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
