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
end