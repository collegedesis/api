require 'spec_helper'

describe MembershipType do
  it { should have_many :memberships }
  it { should respond_to :name }
  it { should respond_to :internal_ref }
end