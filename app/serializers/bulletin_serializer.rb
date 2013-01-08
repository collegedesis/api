class BulletinSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at
end
