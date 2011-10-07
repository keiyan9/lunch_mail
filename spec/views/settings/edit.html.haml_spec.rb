require 'spec_helper'

describe "settings/edit.html.haml" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
      :area => "MyString"
    ))
  end

  it "renders the edit setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => settings_path(@setting), :method => "post" do
      assert_select "input#setting_area", :name => "setting[area]"
    end
  end
end
