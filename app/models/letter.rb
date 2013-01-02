class Letter < ActiveRecord::Base
  belongs_to :user
  has_many :votes, :as => :votable
  has_many :voted_users, through: :votes, source: :user

end
