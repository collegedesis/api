require 'spec_helper'

describe "stories/show" do
  before(:each) do
    @story = assign(:story, stub_model(Story,
      :title => "Title",
      :url => "Url",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Url/)
    rendered.should match(/1/)
  end
end
