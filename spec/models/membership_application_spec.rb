require 'spec_helper'

describe MembershipApplication do
  describe "#approve" do
    let(:user) { FactoryGirl.create(:user) }
    let(:org) { FactoryGirl.create(:organization)}


    context "admin membership"
      let(:app_attributes) do
        {
          user_id: user.id,
          organization_id: org.id,
          membership_type_id: MEMBERSHIP_TYPE_ADMIN
        }
      end
      describe "updates membership_type_id" do

        context "existing membership" do
          it "updates the membership membership_type_id" do
            membership = org.memberships.create(user_id: user.id, membership_type_id: MEMBERSHIP_TYPE_MEMBER)
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

  describe "#should_be_auto_approved?" do
    let(:application) { FactoryGirl.create(:pending_application) }

    context "admin application" do
      before(:each) do
        application.membership_type_id = MEMBERSHIP_TYPE_ADMIN
      end

      it "is false if organization auto approves memberships" do
        application.organization.stub(:auto_approve_memberships) { true }
        expect(application.should_be_auto_approved?).to eq false
      end

      it "is false if organization does not auto approves memberships" do
        application.organization.stub(:auto_approve_memberships) { false }
        expect(application.should_be_auto_approved?).to eq false
      end
    end

    context "membership application" do
      before(:each) do
        application.membership_type_id = MEMBERSHIP_TYPE_MEMBER
      end

      it "is true if organization auto approves" do
        application.organization.stub(:auto_approve_memberships) { true }
        expect(application.should_be_auto_approved?).to eq true
      end

      it "is false if not admin application" do
        application.organization.stub(:auto_approve_memberships) { false }
        expect(application.should_be_auto_approved?).to eq false
      end
    end
  end

  describe "#admin_application?" do
    it "is true if membership_type_id is admin" do
      app = FactoryGirl.create(:pending_application)
      app.membership_type_id = MEMBERSHIP_TYPE_ADMIN
      expect(app.admin_application?).to eq true
    end

    it "is false if membership_type_id is member" do
      app = FactoryGirl.create(:pending_application)
      app.membership_type_id = MEMBERSHIP_TYPE_MEMBER
      expect(app.admin_application?).to eq false
    end
  end
end
