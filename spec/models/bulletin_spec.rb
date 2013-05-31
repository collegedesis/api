require 'spec_helper'

describe Bulletin do

  describe "Creating bulletins" do
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
  end

  it "should return the url if bulletin is a link" do
    bulletin = FactoryGirl.create(:bulletin_link, :url => "http://google.com")
    bulletin.bulletin_url.should == "http://google.com"
  end

  describe "Saving Bulletins" do
    it "should normalize titles that are are in all caps" do
      bulletin = FactoryGirl.create(:bulletin_post, title: "ALL CAPITAL OBNOXIOUS LETTERS")
      bulletin.title.should eq "All Capital Obnoxious Letters"
    end

    it "should normalize titles that are not in all lowercase" do
      bulletin = FactoryGirl.create(:bulletin_post, title: "bulletin title in all lowercase")
      bulletin.title.should eq "Bulletin Title In All Lowercase"
    end

    it "should not normalize titles that are weirdly cased" do
      bulletin = FactoryGirl.create(:bulletin_post, title: "Bulletin title in all lowercase")
      bulletin.title.should eq "Bulletin title in all lowercase"
    end
  end

  describe "Destroying bulletins" do
    before(:each) do
      @bulletin = FactoryGirl.create(:bulletin_post)
    end
    it "should delete all associated comments on destroy" do
      @bulletin.comments.create(body: "Some text")
      comments = @bulletin.comments
      @bulletin.destroy
      comments.should eq []
    end

    it "should delete all associated votes on destroy" do
      @bulletin.votes.create
      votes = @bulletin.votes
      @bulletin.destroy
      votes.should eq []
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
end