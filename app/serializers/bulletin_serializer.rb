class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :url, :bulletin_type
  attribute :vote_ids
end
