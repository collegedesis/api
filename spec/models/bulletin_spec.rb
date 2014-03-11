require 'spec_helper'

describe Bulletin do

  describe "#create" do
    it "can create a valid post bulletin" do
      bulletin = FactoryGirl.create(:bulletin)
      expect(bulletin.valid?).to be true
    end

    it "should create a slug after creating an bulletin" do
      bulletin = FactoryGirl.create(:bulletin)
      expect(bulletin.slug).to eq bulletin.title.parameterize
    end

    it "sets expiration date to 2 days later if none is provided" do
      bulletin = FactoryGirl.build(:bulletin)
      bulletin.should_receive(:set_expiration_date).and_return(nil)
      bulletin.save
    end
  end

  describe "#shareable_link" do
    context "post" do
      it "should include the slug" do
        bulletin = FactoryGirl.create(:bulletin)
        expect(bulletin.shareable_link).to include bulletin.slug
      end
    end

    context "link" do
      it "should include the slug" do
        bulletin = FactoryGirl.create(:bulletin)
        expect(bulletin.shareable_link).to include bulletin.slug
      end
    end
  end

  describe "#approved" do
    let(:user) { FactoryGirl.create(:user) }
    subject(:bulletin) { FactoryGirl.build(:bulletin) }

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
    let(:bulletin) { FactoryGirl.build(:bulletin, score: 1) }
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

  describe "author_name" do
    let(:bulletin) { FactoryGirl.build(:bulletin)}

    context "author is organization" do
      it "is the organization's display name" do
        organization = FactoryGirl.build(:organization)
        organization.stub(:display_name) {"Something"}

        bulletin.author = organization
        expect(bulletin.author_name).to eq "Something"
      end
    end

    context "author is user" do
      it "is the user's full name" do
        user = FactoryGirl.build(:user, full_name: "Gnarls Berkeley")
        bulletin.author = user
        expect(bulletin.author_name).to eq "Gnarls Berkeley"
      end
    end
  end

  describe "author_twitter" do
    let(:author_with_twitter) { mock_model("Organization", twitter: "something") }
    let(:bulletin) { FactoryGirl.build(:bulletin, author: author_with_twitter) }

    context "author has a twitter method" do
      it "returns author's twitter handle if there is one" do
        expect(bulletin.author_twitter).to eq "something"
      end
    end

    context "author does not have a twitter method" do
      let(:author_without_twitter) { mock_model("User") }
      let(:bulletin) { FactoryGirl.build(:bulletin, author: author_without_twitter) }

      it "returns nil" do
        expect(bulletin.author_twitter).to eq nil
      end
    end
  end
end
