require 'spec_helper'

describe Membership do
  it "should approve memberships if the organization auto approves memberships" do
    org = FactoryGirl.create(:organization, :auto_approve_memberships => true)
    user = FactoryGirl.create(:user)
    mem = org.memberships.create(user_id: user.id)
    mem.approved.should eq true
  end

  it "should not approve memberships if the organization does not auto approve membership" do
    org = FactoryGirl.create(:organization, :auto_approve_memberships => false)
    user = FactoryGirl.create(:user)
    mem = org.memberships.create(user_id: user.id)
    mem.approved.should eq false
  end

  describe "Uniquness validations for memberships" do
    before(:each) do
      @org1 = FactoryGirl.create(:organization, email: "something@something.com")
      @org2 = FactoryGirl.create(:organization)
      @user1 = FactoryGirl.create(:user, email: "blah@blah.com")
      @user2 = FactoryGirl.create(:user)
    end
    it "should not create duplicate memberships" do
      mem1 = Membership.create(user_id: @user1.id, organization_id: @org1.id)
      mem2 = Membership.create(user_id: @user1.id, organization_id: @org1.id)
      Membership.count.should eq 1
    end
    it "should be able to create multiple memberships for the same user" do
      mem1 = Membership.create(user_id: @user1.id, organization_id: @org1.id)
      mem2 = Membership.create(user_id: @user1.id, organization_id: @org2.id)
      Membership.count.should eq 2
    end

    it "should be able to create multiple memberships for one organization" do
      mem1 = Membership.create(user_id: @user1.id, organization_id: @org1.id)
      mem2 = Membership.create(user_id: @user2.id, organization_id: @org1.id)
      Membership.count.should eq 2
    end
  end
  describe "deleting memberships" do
    before(:each) do
      @org = FactoryGirl.create(:organization)
      @user = FactoryGirl.create(:user)
      @membership = @org.memberships.create(user_id: @user.id)
      @membership.destroy
    end
    it "sends an email to the user" do
      MemberMailer.should_receive(:removed_membership).with(@membership)
    end
    it "sends an email to the organization" do
      OrganizationMailer.should_receive(:removed_membership).with(@membership)
    end
  end
end