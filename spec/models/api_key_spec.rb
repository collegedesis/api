require 'spec_helper'

describe ApiKey do
  it "generates access token" do
    joe = FactoryGirl.create(:user)
    api_key = ApiKey.create(scope: 'session', user_id: joe.id)
    expect(api_key.access_token).to match(/\S{32}/)
  end

  it "sets the expired_at properly for 'session' scope" do
    joe = FactoryGirl.build(:user)
    api_key = ApiKey.create(scope: 'session', user_id: joe.id)
    expect api_key.expired_at == 4.hours.from_now
  end

  it "sets the expired_at properly for 'api' scope" do
    joe = FactoryGirl.build(:user)
    api_key = ApiKey.create(scope: 'api', user_id: joe.id)
    expect api_key.expired_at == 30.days.from_now
  end
end