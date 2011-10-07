require 'spec_helper'

describe "settings/new.html.haml" do
  before(:each) do
    assign(:setting, stub_model(Setting,
      :area => "MyString"
    ).as_new_record)
  end

  it "renders new setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => settings_path, :method => "post" do
      assert_select "input#setting_area", :name => "setting[area]"
    end
  end
end
