require 'spec_helper'

describe "settings/index.html.haml" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        :area => "Area"
      ),
      stub_model(Setting,
        :area => "Area"
      )
    ])
  end

  it "renders a list of settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Area".to_s, :count => 2
  end
end
