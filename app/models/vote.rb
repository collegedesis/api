class Vote < ActiveRecord::Base
  attr_accessible :submitted_by_ip, :user_id, :votable_id
  belongs_to :votable, :polymorphic => true
  belongs_to :user

  validates_presence_of :votable

  def bulletin_id
    votable_id if votable_type == "Bulletin"
  end
end