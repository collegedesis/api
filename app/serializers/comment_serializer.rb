class CommentSerializer < ApplicationSerializer
  attributes :id, :bulletin_id, :body, :author, :created_at, :user_id
end
