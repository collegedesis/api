class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :website, :display_name, :location, :slug, :university_name

  # Association
  attribute :organization_type_id, key: :org_type_id
  attribute :membership_ids, key: :memberships
end