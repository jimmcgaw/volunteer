require 'spec_helper'

describe "registrations/edit.html.erb" do
  before(:each) do
    @registration = assign(:registration, stub_model(Registration,
      :shift_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => registrations_path(@registration), :method => "post" do
      assert_select "input#registration_shift_id", :name => "registration[shift_id]"
      assert_select "input#registration_user_id", :name => "registration[user_id]"
    end
  end
end
