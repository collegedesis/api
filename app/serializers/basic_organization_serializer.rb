class BasicOrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :website, :display_name, :location, :slug, :university_name, :about, :reputation, :twitter, :facebook, :youtube
end