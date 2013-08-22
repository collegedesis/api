require 'spec_helper'

describe Bulletin, focus: true do

  describe "is_link?" do
    it "returns true if bulletin type is link" do
      bulletin = FactoryGirl.build(:bulletin, bulletin_type: BULLETIN_TYPE_LINK)
      expect(bulletin.is_link?).to eq true
    end
    it "returns false if bulletin type is not link" do
      bulletin = FactoryGirl.build(:bulletin, bulletin_type: BULLETIN_TYPE_POST)
      expect(bulletin.is_link?).to eq false
    end
  end

  describe "is_post?" do
    it "returns true if bulletin type is post" do
      bulletin = FactoryGirl.build(:bulletin, bulletin_type: BULLETIN_TYPE_POST)
      expect(bulletin.is_post?).to eq true
    end
    it "returns false if bulletin type is not post" do
      bulletin = FactoryGirl.build(:bulletin, bulletin_type: BULLETIN_TYPE_LINK)
      expect(bulletin.is_post?).to eq false
    end
  end

  describe "#expire" do
    it "sets expire to true if should be expired" do
      bulletin = FactoryGirl.create(:bulletin_post)
      bulletin.stub(:should_be_expired?) { true }
      bulletin.expire
      expect(bulletin.expired).to eq true
    end

    it "doesn't expire if should not be expired" do
      bulletin = FactoryGirl.create(:bulletin_post)
      bulletin.stub(:should_be_expired?) { false }
      bulletin.expire
      expect(bulletin.expired).to eq false
    end
  end

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
    context "post" do
      it "should include the slug" do
        bulletin = FactoryGirl.create(:bulletin_post)
        expect(bulletin.relative_local_url).to include bulletin.slug
      end
    end

    context "link" do
      it "should include the slug" do
        bulletin = FactoryGirl.create(:bulletin_post)
        expect(bulletin.relative_local_url).to include bulletin.slug
      end
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