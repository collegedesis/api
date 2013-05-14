require 'spec_helper'

describe Organization do
  it "can create a valid organization" do
    org = Organization.create(name: 'Cool org', email: 'something@cool.com', university_id: 1, organization_type_id: 1)
    org.valid?.should be_true
  end
end