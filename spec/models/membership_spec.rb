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
end