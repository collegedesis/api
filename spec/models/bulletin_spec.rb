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

  it "should properly capitalize bulletin titles in all caps" do
    bulletin = FactoryGirl.create(:bulletin_post, title: "THIS IS AN OBNOXIOUS TITLE")
    bulletin.title.should eq "This is an obnoxious title"
  end

  it "should properly capitalize a bulletin that is in all lowercase" do
    bulletin = FactoryGirl.create(:bulletin_post, title: "this is a lame title")
    bulletin.title.should eq "This is a lame title"
  end
end