class OrganizationTypeSerializer < ActiveModel::Serializer 
  attributes :id, :name, :category
  embed :ids
  has_many :organizations
end