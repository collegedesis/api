require 'spec_helper'

describe OrganizationsController, :type => :controller do

  describe "index" do
    let!(:organization) { FactoryGirl.create(:organization) }
    it 'should return organizations in json' do
      get :index
      response.should be_success
    end

    describe "root key" do
      it 'includes the root organizations key' do
        get :index
        response_json = JSON.parse(response.body)
        expect(response_json.keys.include?("organizations")).to eq true
      end

      it "includes only one root key" do
        get :index
        response_json = JSON.parse(response.body)
        expect(response_json.keys.length).to eq 1
      end

      it "includes an array under the organizations key" do
        FactoryGirl.create(:organization)
        get :index
        response_json = JSON.parse(response.body)
        expect(response_json["organizations"].class).to eq Array
      end
    end

    describe "inside root key" do

      before(:each) do
        get :index
        response_json = JSON.parse(response.body)
        @orgs_json_keys = response_json["organizations"].first.keys
      end

      it "includes the organizations name" do
        expect(@orgs_json_keys.include?("name")).to eq true
      end

      it "includes the about" do
        expect(@orgs_json_keys.include?("about")).to eq true
      end

      it "includes the reputation" do
        expect(@orgs_json_keys.include?("reputation")).to eq true
      end

      it "includes the website" do
        expect(@orgs_json_keys.include?("website")).to eq true
      end

      it "includes the slug" do
        expect(@orgs_json_keys.include?("slug")).to eq true
      end

      it "includes the twitter" do
        expect(@orgs_json_keys.include?("twitter")).to eq true
      end

      it "includes the facebook" do
        expect(@orgs_json_keys.include?("facebook")).to eq true
      end

      it "includes the university_name" do
        expect(@orgs_json_keys.include?("university_name")).to eq true
      end

      it "includes the display_name" do
        expect(@orgs_json_keys.include?("display_name")).to eq true
      end
    end
  end
end
