require 'spec_helper'

describe "stories/new" do
  before(:each) do
    assign(:story, stub_model(Story,
      :title => "MyString",
      :url => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stories_path, :method => "post" do
      assert_select "input#story_title", :name => "story[title]"
      assert_select "input#story_url", :name => "story[url]"
      assert_select "input#story_user_id", :name => "story[user_id]"
    end
  end
end
