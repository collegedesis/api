require 'spec_helper'

describe Bulletin do
  it "can create a valid post bulletin" do
    bulletin = FactoryGirl.create(:bulletin_post)
    bulletin.is_post?.should be_true
  end

  it "can create a valid link bulletin" do
    bulletin = FactoryGirl.create(:bulletin_link)
    bulletin.is_link?.should be_true
  end

  it "should create a slug after creating an bulletin" do
    bulletin = FactoryGirl.create(:bulletin_post)
    bulletin.slug.should == bulletin.title.parameterize
  end

  it "should return the url if bulletin is a link" do
    bulletin = FactoryGirl.create(:bulletin_link, :url => "http://google.com")
    bulletin.bulletin_url.should == "http://google.com"
  end
end