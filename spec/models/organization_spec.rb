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

  describe "#directory_profile" do
    it "has a link to its profile in the directory" do
      org = FactoryGirl.create(:organization)
      org.stub(:slug) { "something-cray-cray"}
      expect(org.directory_profile).to eq "https://collegedesis.com/#/d/something-cray-cray"
    end

    it "returns base directory if there is no slug" do
      org = FactoryGirl.create(:organization)
      org.stub(:slug) { nil }
      expect(org.directory_profile).to eq "https://collegedesis.com/#/directory"
    end
  end
end