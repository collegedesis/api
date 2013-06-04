class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at
  attributes :bulletin_type, :slug, :author_id
  attributes :vote_ids, :comment_ids
  attribute :url_to_serialize, key: :url
end