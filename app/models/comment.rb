class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type, :user_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  def bulletin_id
    commentable.id if commentable_type == "Bulletin"
  end

  def author
    user.full_name if user
  end
end
