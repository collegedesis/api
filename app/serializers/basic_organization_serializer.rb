class BasicOrganizationSerializer < ApplicationSerializer
  attributes :id, :name, :website,
              :display_name, :location, :slug, :university_name,
              :about, :reputation, :twitter, :facebook, :youtube
end