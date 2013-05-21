require 'spec_helper'

describe Organization do
  it "must have an auto approve attribute" do
    org = FactoryGirl.create(:organization)
    org.auto_approve_memberships.should_not eq nil
  end

  it "can create a valid organization" do
    org = FactoryGirl.create(:organization)
    org.valid?.should be_true
  end

  it "should create a slug after creating an organization" do
    org = FactoryGirl.create(:organization)
    org.slug.should == org.display_name.parameterize
  end
end