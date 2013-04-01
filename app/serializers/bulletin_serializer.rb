class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :url, :bulletin_type, :user_id, :slug
  attribute :vote_ids, key: :votes
end
