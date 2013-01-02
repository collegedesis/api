require 'spec_helper'

describe "letters/new" do
  before(:each) do
    assign(:letter, stub_model(Letter,
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new letter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => letters_path, :method => "post" do
      assert_select "textarea#letter_body", :name => "letter[body]"
    end
  end
end
