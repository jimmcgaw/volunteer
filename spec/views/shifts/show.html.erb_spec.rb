require 'spec_helper'

describe "shifts/show.html.erb" do
  before(:each) do
    @shift = assign(:shift, stub_model(Shift,
      :title => "Title",
      :description => "MyText",
      :event_id => 1,
      :volunteer_count => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
