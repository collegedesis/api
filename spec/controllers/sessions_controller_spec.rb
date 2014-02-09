require 'spec_helper'

describe SessionsController do

  let(:pw) { 'secret' }
  let(:larry) do
    FactoryGirl.create(:user, password: pw, password_confirmation: pw)
  end

  it 'authenticates with email' do
    post 'create', { session: { email: larry.email, password: pw } }
    results = JSON.parse(response.body)
    expect(results['api_key']['access_token']).to match(/\S{32}/)
    expect(results['api_key']['user_id']).to eq(larry.id)
  end

  it "does not authenticate with invalid info" do
    post 'create', { session: { email: larry.email, password: 'huh' } }
    expect(response.status).to eq(401)
  end
end