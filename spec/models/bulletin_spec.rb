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
    bulletin.relative_local_url.should == "http://google.com"
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

  it "sorts bulletins array in descending order by score" do
    bulletin1 = FactoryGirl.create(:bulletin_post)
    bulletin2 = FactoryGirl.create(:bulletin_post)
    bulletin1.stub(:score) { 10 }
    bulletin2.stub(:score) { 5 }

    bulletins = [bulletin1, bulletin2]
    sorted = Bulletin.sort_by_score(bulletins)
    expect(sorted[0]).to eq(bulletin1)
    expect(sorted[1]).to eq(bulletin2)
  end

  it "paginates by page size" do
    bulletins = FactoryGirl.create_list(:approved_bulletin, 20)
    page_size = 10
    paginated_bulletins = Bulletin.paginate(bulletins, page_size)
    expect(paginated_bulletins.length).to eq 2
    expect(paginated_bulletins[0].length).to eq page_size
    expect(paginated_bulletins[1].length).to eq page_size
  end

  describe ".alive" do
    it "does return alive bulletins" do
      bulletin = FactoryGirl.create(:bulletin_post, is_dead: false)
      Bulletin.alive.include? bulletin
    end
    it "does not return dead bulletins" do
      bulletin = FactoryGirl.create(:bulletin_post, is_dead: false)
      !Bulletin.alive.include? bulletin
    end
  end

  describe ".homepage" do
    it "does not return more than 10 items" do
      FactoryGirl.create_list(:bulletin_post, 11)
      expect(Bulletin.homepage("1").length).to eq(10)
    end
    it "returns all the items when then are less than 10 items" do
      FactoryGirl.create_list(:bulletin_post, 4)
      expect(Bulletin.homepage("1").length).to eq(4)
    end
    it "does not return bulletins that are dead" do
      FactoryGirl.create_list(:bulletin_post, 4, is_dead: true)
      expect(Bulletin.homepage("1").length).to eq(0)
    end

    it "does not return bulletins that don't have a user assigned" do
      bulletin = FactoryGirl.build(:bulletin_post, user_id: nil)
      bulletin.stub(:valid?) { true }
      bulletin.save
      Bulletin.homepage("1").should_not include(bulletin)
    end

    it "does not return bulletins that have unapproved users" do
      bulletin = FactoryGirl.create(:bulletin_post)
      bulletin.user.stub(:approved?) { false }
      Bulletin.homepage("1").should_not include(bulletin)
    end

    it "defaults to first page if it is not provided with one"
  end
end