class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at
  attributes :bulletin_type, :slug, :author_id, :author_type, :url
  attribute :score
  attribute :comment_ids
end