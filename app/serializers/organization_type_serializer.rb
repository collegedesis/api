class OrganizationTypeSerializer < ApplicationSerializer 
  attributes :id, :name, :category
  has_many :organizations
end