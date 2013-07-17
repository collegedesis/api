class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at
  attributes :bulletin_type, :slug, :author_id, :author_type
  attribute :url_to_serialize, key: :url
  attribute :score
  attribute :comment_ids
end