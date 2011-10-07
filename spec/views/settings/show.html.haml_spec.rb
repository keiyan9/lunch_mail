require 'spec_helper'

describe "settings/show.html.haml" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
      :area => "Area"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Area/)
  end
end
