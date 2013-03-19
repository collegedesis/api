class Bulletin < ActiveRecord::Base
  attr_accessible :body, :title, :url, :bulletin_type
  has_many :votes, :as => :votable

  def self.find_by_title(title)
    Bulletin.where("lower(title) = lower(:title)", :title => title)
  end
end
