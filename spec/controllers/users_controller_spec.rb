require 'spec_helper'

describe UsersController do
  it "#create" do
    post 'create', {
      user: {
        username: 'billy',
        full_name: 'Billy Blowers',
        email: 'billy_blowers@example.com',
        password: 'secret',
        password_confirmation: 'secret'
      }
    }
    results = JSON.parse(response.body)
    expect(results['api_key']['access_token']).to match(/\S{32}/)
    expect(results['api_key']['user_id']).to be > 0
  end

  it "#create with invalid data" do
    post 'create', {
      user: {
        username: '',
        full_name: 'Billy Blowers',
        email: 'foo',
        password: 'secret',
        password_confirmation: 'something_else'
      }
    }
    results = JSON.parse(response.body)
    expect(results.size).to eq(1)
  end

  it "#show" do
    joe = FactoryGirl.create(:user)
    get 'show', { id: joe.id }
    results = JSON.parse(response.body)
    expect(results['user']['id']).to eq(joe.id)
    expect(results['user']['full_name']).to eq(joe.full_name)
  end

end