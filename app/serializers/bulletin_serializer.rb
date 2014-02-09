class BulletinSerializer < ApplicationSerializer
  attributes :id, :title, :body, :created_at, :slug, :author_id, :author_type, :url, :score, :views_count
  has_many :comments
end