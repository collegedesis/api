require 'spec_helper'

describe OrganizationsController, :type => :controller do

  describe "index" do
    let!(:organization) { FactoryGirl.create(:organization) }
    it 'should return organizations in json' do
      get :index
      response.should be_success
    end

    describe "root key" do
      let(:response_json) { JSON.parse(response.body) }
      it 'includes the root organizations key' do
        get :index
        expect(response_json.keys.include?("organizations")).to eq true
      end

      it "includes only one root key" do
        get :index
        expect(response_json.keys.length).to eq 1
      end

      it "includes an array under the organizations key" do
        FactoryGirl.create(:organization)
        get :index
        expect(response_json["organizations"].class).to eq Array
      end
    end

    describe "inside root key" do
      let(:response_json) { JSON.parse(response.body) }
      let(:orgs_json_keys) { response_json["organizations"].first.keys }

      it "includes the organizations name" do
        get :index
        expect(orgs_json_keys.include?("name")).to eq true
      end

      it "includes the about" do
        get :index
        expect(orgs_json_keys.include?("about")).to eq true
      end

      it "includes the reputation" do
        get :index
        expect(orgs_json_keys.include?("reputation")).to eq true
      end

      it "includes the website" do
        get :index
        expect(orgs_json_keys.include?("website")).to eq true
      end

      it "includes the slug" do
        get :index
        expect(orgs_json_keys.include?("slug")).to eq true
      end

      it "includes the twitter" do
        get :index
        expect(orgs_json_keys.include?("twitter")).to eq true
      end

      it "includes the facebook" do
        get :index
        expect(orgs_json_keys.include?("facebook")).to eq true
      end

      it "includes the university_name" do
        get :index
        expect(orgs_json_keys.include?("university_name")).to eq true
      end

      it "includes the display_name" do
        get :index
        expect(orgs_json_keys.include?("display_name")).to eq true
      end
    end
  end

  describe "#update" do
    context "logged in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        controller.stub(:current_user) { @user }
      end

      context "admin" do
        it "should update attributes" do
          org = FactoryGirl.create(:organization)
          membership = org.memberships.create(user_id: @user.id, membership_type_id: MEMBERSHIP_TYPE_ADMIN)
          put :update, id: org.id, organization: {name: "New name"}
          org.reload
          expect(org.name).to eq "New name"
        end
      end

      context "not admin" do
        it "should not update attributes" do
          org = FactoryGirl.create(:organization)
          membership = org.memberships.create(user_id: @user.id, membership_type_id: MEMBERSHIP_TYPE_MEMBER)
          put :update, id: org.id, organization: {name: "New name"}
          org.reload
          expect(org.name).to eq org.name
        end

        it "returns 401" do
          org = FactoryGirl.create(:organization)
          put :update, id: org.id, organization: {name: "New name"}
          expect(response.status).to eq 401
        end

        it "returns 'Unauthorized' in the response body" do
          org = FactoryGirl.create(:organization)
          put :update, id: org.id, organization: {name: "New name"}
          response_json = JSON.parse(response.body)
          expect(response_json["errors"]).to eq "Unauthorized"
        end
      end
    end

    context "not logged in" do
      it "should not update attributes" do
        controller.stub(:current_user) { nil }
        org = FactoryGirl.create(:organization)
        put :update, id: org.id, organization: {name: "New name"}
        org.reload
        expect(org.name).to eq org.name
      end

      it "returns 401" do
        org = FactoryGirl.create(:organization)
        put :update, id: org.id, organization: {name: "New name"}
        expect(response.status).to eq 401
      end

      it "returns 'Unauthorized' in the response body" do
        org = FactoryGirl.create(:organization)
        put :update, id: org.id, organization: {name: "New name"}
        response_json = JSON.parse(response.body)
        expect(response_json["errors"]).to eq "Unauthorized"
      end
    end
  end
end
