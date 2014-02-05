class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at
  attributes :bulletin_type, :slug, :author_id, :author_type, :url, :views_count
  attribute :score
  attribute :comment_ids
end