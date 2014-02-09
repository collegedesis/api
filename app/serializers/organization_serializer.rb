class OrganizationSerializer < ApplicationSerializer
  attributes :id, :name, :website,
            :display_name, :location, :slug,
            :university_name, :about, :reputation,
            :twitter, :facebook, :youtube, :instagram

  attribute :organization_type_id, key: :org_type_id

  has_many :memberships
  has_many :membership_applications
  has_many :recent_bulletins, root: :bulletins

  def recent_bulletins
    object.bulletins.recent
  end
end