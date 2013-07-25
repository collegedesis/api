require 'spec_helper'

describe Membership do

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

  describe ".create_and_approve_with_application" do
    let(:application) { FactoryGirl.create(:pending_application) }

    before(:each) do
      @mem = Membership.create_and_approve_with_application(application)
    end
    it "creates an approved membership" do
      expect(@mem.approved).to eq true
    end

    it "creates a membership with the same membership_type_id as application" do
      expect(@mem.membership_type_id).to eq application.membership_type_id
    end

    it "has the same organization as applcation" do
      expect(@mem.user).to eq application.user
    end

    it "has the same organization as applcation" do
      expect(@mem.organization).to eq application.organization
    end
  end

end