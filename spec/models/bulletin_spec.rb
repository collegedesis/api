require 'spec_helper'

describe Bulletin do
  it "can create a valid bulletin" do
    bulletin = FactoryGirl.create(:bulletin)
    bulletin.valid?.should be_true
  end

  it "should create a slug after creating an bulletin" do
    bulletin = FactoryGirl.create(:bulletin)
    bulletin.slug.should == bulletin.title.parameterize
  end
end