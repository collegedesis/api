class OrganizationSerializer < ActiveModel::Serializer 
  attributes :id, :name, :website, :exposed, :display_name

  attribute :has_email?, key: :has_email
  # Association
  attribute :organization_type_id, key: :org_type_id
  attribute :membership_ids, key: :memberships
end