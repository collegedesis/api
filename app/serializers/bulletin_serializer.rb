class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :url, :bulletin_type, :user_id, :slug, :author
  attribute :vote_ids, key: :votes
  attribute :comment_ids, key: :comments
end
