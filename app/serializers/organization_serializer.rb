class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :website, :display_name, :location, :slug, :university_name, :about, :reputation

  # Association
  attribute :organization_type_id, key: :org_type_id
  attribute :approved_membership_ids, key: :membership_ids
end