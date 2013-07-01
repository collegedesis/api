require 'spec_helper'

describe Bulletin, focus: true do

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

  describe ".paginated_bulletins" do
    # TODO this should probably be tested better
    it "paginates by page size" do
      bulletins = FactoryGirl.create_list(:approved_bulletin, 20)
      paginated_bulletins = Bulletin.paginate(bulletins)
      expect(paginated_bulletins.length).to eq 2
    end
  end

  describe ".alive" do
    let(:bulletin) { FactoryGirl.create(:bulletin_post) }
    it "includes alive bulletins" do
      bulletin.update_attributes(is_dead: false )
      expect(Bulletin.alive.include? bulletin).to eq true
    end

    it "does not include dead bulletins" do
      bulletin.update_attributes(is_dead: true )
      expect(Bulletin.alive.include? bulletin).to eq false
    end
  end
end