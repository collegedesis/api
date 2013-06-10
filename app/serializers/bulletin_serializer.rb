class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at
  attributes :bulletin_type, :slug, :author_id
  attribute :url_to_serialize, key: :url
  attribute :score
end