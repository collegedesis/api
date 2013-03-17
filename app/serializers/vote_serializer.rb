class VoteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :bulletin_id
end