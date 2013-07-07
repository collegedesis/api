require 'spec_helper'

describe MembershipApplication do
  describe "#approve" do
    let(:user) { FactoryGirl.create(:user) }
    let(:org) { FactoryGirl.create(:organization)}
    let(:app_attributes) { {user_id: user.id, organization_id: org.id} }
    it "updates the application status to approved" do

    end

    describe "updates membership_type_id" do
      before(:each) { app_attributes[:membership_type_id] = MEMBERSHIP_TYPE_ADMIN }

      context "existing membership" do
        it "updates the membership membership_type_id" do
          membership = org.memberships.create(user_id: user.id, membership_type_id: 1)
          app = MembershipApplication.create(app_attributes)
          app.approve
          membership.reload
          expect(membership.membership_type_id).to eq MEMBERSHIP_TYPE_ADMIN
        end
      end

      context "no existing membership" do
        it "creates a new membership with the correct membership_type_id" do
          app = MembershipApplication.create(app_attributes)
          app.approve
          membership = Membership.where(organization_id: org.id, user_id: user.id).first
          expect(membership.membership_type_id).to eq MEMBERSHIP_TYPE_ADMIN
        end
      end
    end


  end
end
