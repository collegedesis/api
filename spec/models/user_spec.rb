require 'spec_helper'

describe User do
  describe "Destroying user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it "should delete all associated memberships on destroy" do
      org = FactoryGirl.create(:organization)
      @user.memberships.create(organization_id: org.id)
      memberships = @user.memberships
      @user.destroy
      memberships.should eq []
    end

    it "should delete all associated comments on destroy" do
      @user.comments.create(commentable_id: 1)
      comments = @user.comments
      @user.destroy
      comments.should eq []
    end
    it "should delete all associated bulletins on destroy" do
      bulletin = FactoryGirl.create(:bulletin, user_id: @user.id)
      bulletins = @user.bulletins
      @user.destroy
      bulletins.should eq []
    end
  end

  describe "#update_approved_status" do
    let(:user) { user = FactoryGirl.create(:user) }
    context "has_approved_membership" do
      it "updates approved to false" do
        user.stub(:has_approved_membership?) { false }
        user.update_approved_status
        expect(user.approved).to eq false
      end
    end
    context "does not have approved membership" do
      it "updates approved to true" do
        user.stub(:has_approved_membership?) { true }
        user.update_approved_status
        expect(user.approved).to eq true
      end
    end
  end

  describe "#is_admin_of?" do
    let(:org) { FactoryGirl.create(:organization) }
    it "is true if user has an admin membership" do
      user = FactoryGirl.create(:user)
      user.memberships.create(organization_id: org.id, membership_type_id: MEMBERSHIP_TYPE_ADMIN)
      expect(user.is_admin_of?(org)).to eq true
    end

    it "is false if user does not have an admin membership" do
      user = FactoryGirl.create(:user)
      user.memberships.create(organization_id: org.id, membership_type_id: MEMBERSHIP_TYPE_MEMBER)
      expect(user.is_admin_of?(org)).to eq false
    end

    it "is false if user is not a member of org", focus: true do
      user = FactoryGirl.create(:user)
      expect(user.is_admin_of?(org)).to eq false
    end
  end

  describe '#api_key' do
    it "#session" do
      joe = FactoryGirl.create(:user)
      api_key = joe.session_api_key
      expect(api_key.access_token).to match(/\S{32}/)
      expect(api_key.user_id).to eq(joe.id)
    end
  end
end