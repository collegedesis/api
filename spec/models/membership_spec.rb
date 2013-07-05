require 'spec_helper'

describe Membership do

  describe "#new" do
    let(:user) { FactoryGirl.create(:user) }
    it "should be approved if the organization auto approves memberships" do
      org = FactoryGirl.create(:organization, :auto_approve_memberships => true)
      mem = org.memberships.create(user_id: user.id)
      mem.approved.should eq true
    end
    it "should not approve memberships if the organization does not auto approve membership" do
      org = FactoryGirl.create(:organization, :auto_approve_memberships => false)
      mem = org.memberships.create(user_id: user.id)
      mem.approved.should eq false
    end
  end

  describe "Uniquness validations for memberships" do
    before(:each) do
      @org1 = FactoryGirl.create(:organization)
      @org2 = FactoryGirl.create(:organization)
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
    end

    it "does not create duplicate memberships" do
      Membership.create(user_id: @user1.id, organization_id: @org1.id)
      mem2 = Membership.new(user_id: @user1.id, organization_id: @org1.id)
      expect(mem2.valid?).to eq false
      expect(mem2.errors.messages.keys.include?(:user_id)).to eq true
    end

    it "can create multiple memberships for the same user" do
      Membership.create(user_id: @user1.id, organization_id: @org1.id)
      mem2 = Membership.new(user_id: @user1.id, organization_id: @org2.id)
      expect(mem2.valid?).to eq true
    end

    it "can create multiple memberships for the same organization" do
      Membership.create(user_id: @user1.id, organization_id: @org1.id)
      mem2 = Membership.new(user_id: @user2.id, organization_id: @org1.id)
      expect(mem2.valid?).to eq true
    end
  end

  describe "#destroy" do
    let(:org)         { FactoryGirl.create(:organization) }
    let(:user)        { FactoryGirl.create(:user) }
    let(:membership)  { org.memberships.create(user_id: user.id) }

    it "sends an email to the user" do
      mailer = mock(MemberMailer)
      mailer.should_receive(:deliver)
      MemberMailer.should_receive(:membership_rejected).with(membership).and_return(mailer)
      membership.destroy
    end
    it "sends an email to the organization" do
      mailer = mock(OrganizationMailer)
      mailer.should_receive(:deliver)
      OrganizationMailer.should_receive(:membership_rejected).with(membership).and_return(mailer)
      membership.destroy
    end
  end
end