require 'spec_helper'

describe "shifts/edit.html.erb" do
  before(:each) do
    @shift = assign(:shift, stub_model(Shift,
      :title => "MyString",
      :description => "MyText",
      :event_id => 1,
      :volunteer_count => 1
    ))
  end

  it "renders the edit shift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shifts_path(@shift), :method => "post" do
      assert_select "input#shift_title", :name => "shift[title]"
      assert_select "textarea#shift_description", :name => "shift[description]"
      assert_select "input#shift_event_id", :name => "shift[event_id]"
      assert_select "input#shift_volunteer_count", :name => "shift[volunteer_count]"
    end
  end
end
