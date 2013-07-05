require 'spec_helper'

describe Bulletin, focus: true do

  describe "#create" do
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

    it "should nullify body if bulletin is post" do
      bulletin = FactoryGirl.create(:bulletin_link, body: "Some text that should be nullified")
      bulletin.body.should be_nil
    end

    it "should not nullify body if bulletin is post" do
      bulletin = FactoryGirl.create(:bulletin_post, body: "Some text that should NOT be nullified")
      bulletin.body.should_not be_nil
    end

    it "sets expiration date to 2 days later if none is provided" do
      bulletin = FactoryGirl.build(:bulletin_post)
      bulletin.should_receive(:set_expiration_date).and_return(nil)
      bulletin.save
    end
  end


  describe "#relative_local_url" do
    it "should return the url if bulletin is a link"do
      bulletin = FactoryGirl.create(:bulletin_link, :url => "http://google.com")
      bulletin.relative_local_url.should == "http://google.com"
    end
  end

  describe "#approved" do
    let(:user) { FactoryGirl.create(:user) }
    subject(:bulletin) { FactoryGirl.build(:bulletin_post) }

    it "is false if the user is not approved" do
      bulletin.user_id = user.id
      bulletin.user.stub(:approved?) { false }
      expect(bulletin.approved?).to eq(false)
    end

    it "is true if the user is approved" do
      bulletin.user_id = user.id
      bulletin.user.stub(:approved?) { true }
      expect(bulletin.approved?).to eq(true)
    end
  end

  describe ".alive" do
    let(:bulletin) { FactoryGirl.build(:bulletin_post, score: 1) }
    it "includes alive bulletins" do
      bulletin.expired = false
      bulletin.save
      expect(Bulletin.alive.include? bulletin).to eq true
    end

    it "does not include dead bulletins" do
      bulletin.expired = true
      bulletin.save
      expect(Bulletin.alive.include? bulletin).to eq false
    end
  end
end