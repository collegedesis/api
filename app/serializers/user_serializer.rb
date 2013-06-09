class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :avatar_url, :approved
  attributes :membership_ids, :bulletin_ids
end