require 'spec_helper'

describe "letters/edit" do
  before(:each) do
    @letter = assign(:letter, stub_model(Letter,
      :body => "MyText"
    ))
  end

  it "renders the edit letter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => letters_path(@letter), :method => "post" do
      assert_select "textarea#letter_body", :name => "letter[body]"
    end
  end
end
