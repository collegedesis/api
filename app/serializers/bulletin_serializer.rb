class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :url, :bulletin_type, :user_id, :slug, :author_id
  attributes :vote_ids, :comment_ids
end
