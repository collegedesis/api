require 'spec_helper'

describe OrganizationsController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }

  it 'should return organizations in json' do
    organization.valid?

    get :index
    hash = {
      organizations: [{
        id: organization.id,
        name: organization.name,
        website: organization.website,
        display_name: "#{organization.name} (#{organization.university.name})",
        location: organization.university.state,
        slug: organization.display_name.parameterize,
        university_name: organization.university.name,
        org_type_id: organization.organization_type.id,
        membership_ids: []
      }]
    }
    response.body.should == hash.to_json
  end

  it 'should return organization records with a root key'

  it 'should not serialize the email field'

  it 'should serialize name'
  it 'should serialize university_id'
  it 'should serialize organization_type_id'

end