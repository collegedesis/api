class CommentSerializer < ActiveModel::Serializer
  attributes :id, :bulletin_id, :body, :author
end
